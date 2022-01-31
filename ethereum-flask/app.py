"""
Bootstrap flask application
"""

import os
import json
from Crypto.Hash import keccak
from eth_account import account
from markupsafe import re
from web3 import Web3
from flask import Flask, jsonify
from web3.types import ParityTraceMode
from utils.block import transform_block
from utils.transaction import list_transactions, transform_transaction
import firebase_admin
from firebase_admin import credentials, firestore, initialize_app

from flask_cors import CORS, cross_origin

script_dir = os.path.dirname(__file__)
file_path_config = os.path.join(script_dir, 'config.json')
file_key_config = os.path.join(script_dir, 'key.json')

with open(file_path_config, 'r') as f:
    config = json.load(f)

with open(file_key_config, 'r') as f:
    keyConfig = json.load(f)

cred = credentials.Certificate(keyConfig)
app =firebase_admin.initialize_app(cred)
db = firestore.client()

APP = Flask(__name__)
URL = config['URL'] 
W3 = Web3(Web3.HTTPProvider(URL)) 

APP.config['CORS_HEADERS'] = 'Content-Type'
cors = CORS(APP, resources={r"/*": {"origins": "https://localhost:4200"}})

contractAddress = config['Contract_Address']
selfCheckInAddress= config['Self_Checkin_Address']
file_path = os.path.join(script_dir, 'abi/abiToken.json')
standard_token_abi = json.load(open(file_path))
selfcheckin_abi = json.load(open(os.path.join(script_dir, 'abi/selfcheckin_abi.json')))
contract = W3.eth.contract(contractAddress, abi=standard_token_abi)
selfCheckInContract = W3.eth.contract(selfCheckInAddress, abi=selfcheckin_abi)
minterAddress = config['Minter_Address']


@APP.route("/tx/<transid>", methods=["GET"])
@cross_origin(origin='localhost',headers=['Content- Type','Authorization'])
def get_by_id(transid) -> dict:
    """
    Searches for a transaction by ID and returns the
    sender and the reciever details

    param
    transid(string): transaction hash

    return
    data(dict): filtered transaction block
    """
    try:
        transaction = W3.eth.getTransaction(transid)
        data = transform_transaction(transaction)
        return jsonify({"data": data}), 200
    except ValueError:
        return jsonify({"message": "Invalid Transaction Hash."}), 400


@APP.route("/newAccount", methods=["GET"])
@cross_origin(origin='localhost',headers=['Content- Type','Authorization'])
def get_account() -> dict:
    """
    Searches for a transaction by ID and returns the
    sender and the reciever details

    param
    transid(string): transaction hash

    return
    data(dict): filtered transaction block
    """
    try:
        newAccount = W3.geth.personal.new_account('the-passphrase')
        return jsonify({"data": newAccount}), 200
    except ValueError:
        return jsonify({"message": "Invalid Transaction Hash."}), 400



@APP.route("/address/<address1>", methods=["GET"])
@cross_origin(origin='localhost',headers=['Content- Type','Authorization'])
def get_by_address(address1) -> dict:
    """
    Returns transactions and balance of an address

    param
    address(string): account address

    return
    balance(int): account balance
    transactions(list): list of transformed transaction blocks
    """
    try:
        if W3.isAddress(address1):
            raw_balance = contract.functions.balanceOf(address1).call()
            balance = W3.fromWei(raw_balance, 'ether')
            transactions = list_transactions(W3, address1)
            return jsonify({"data":{"balance": balance, "transactions": transactions}}), 200
        return jsonify({"message": "Invalid Ethereum Address."}), 400
    except ValueError as error:
        return jsonify({"message": error}), 400


@APP.route("/address/<address>/outgoing", methods=["GET"])
@cross_origin(origin='localhost',headers=['Content- Type','Authorization'])
def get_outgoing(address) -> dict:
    """
    Returns outgoing transactions of an address

    param
    address(string): account address

    return
    transactions(list): list of transformed outgoing transaction blocks
    """
    outgoing = []
    try:
        if W3.isAddress(address):
            transactions = list_transactions(W3, address)
            for data in transactions:
                if "to" in data:
                    outgoing.append(data)
            return jsonify({"data":{"transactions": outgoing}}), 200
        return jsonify({"message": "Invalid Ethereum Address."}), 400
    except ValueError as error:
        return jsonify({"message": error}), 400


@APP.route("/address/<address>/incoming", methods=["GET"])
@cross_origin(origin='localhost',headers=['Content- Type','Authorization'])
def get_incoming(address) -> dict:
    """
    Returns incoming transactions of an address

    param
    address(string): account address

    return
    transactions(list): list of transformed incoming transaction blocks
    """
    incoming = []
    try:
        if W3.isAddress(address):
            transactions = list_transactions(W3, address)
            for data in transactions:
                if "from" in data:
                    incoming.append(data)
            return jsonify({"data":{"transactions": incoming}}), 200
        return jsonify({"message": "Invalid Ethereum Address."}), 400
    except ValueError as error:
        return jsonify({"message": error}), 400


@APP.route("/block/<int:height>", methods=["GET"])
@cross_origin(origin='localhost',headers=['Content- Type','Authorization'])
def get_block(height) -> dict:
    """
    Returns details on a requested block

    param
    height(int): block number

    return
    block(dict): dictionary of block details
    """
    try:
        block = W3.eth.getBlock(height)
        details = transform_block(block)
        return jsonify({"data": details}), 200
    except ValueError:
        return jsonify({"message": "Something went wrong. Please try again."}), 400


@APP.route("/send/<sendAddress>/<int:token>/<toAddress>", methods=["GET"])
@cross_origin(origin='localhost',headers=['Content- Type','Authorization'])
def send(token, sendAddress, toAddress) -> dict:
    """
    Returns details on a requested block

    param
    height(int): block number

    return
    block(dict): dictionary of block details
    """
    try:
        token_to_send = int(token)
        contract.functions.transfer(toAddress, W3.toWei(token, 'ether')).transact({'from': sendAddress})
        return jsonify({"data": 'ok'}), 200
    except Exception as e: 
        return str(e) 

        

@APP.route("/mint/<int:token>/<sendAddress>", methods=["GET"])
@cross_origin(origin='localhost',headers=['Content- Type','Authorization'])
def mint(sendAddress, token) -> dict:
    """
    Returns details on a requested block

    param
    height(int): block number

    return
    block(dict): dictionary of block details
    """
    try:
        token_to_send = int(token)
        receiver = str(sendAddress)
        tx_hash = contract.functions.mint(receiver, W3.toWei(token_to_send, 'ether')).transact({'from': minterAddress})
        tx_receipt = W3.eth.wait_for_transaction_receipt(tx_hash)
        return jsonify({"data": 'ok'}), 200
    except ValueError:
        return jsonify({"message": "Something went wrong. Please try again."}), 400

@APP.route("/selfcheckin/authenticate/<user>/<destination>/<assetURI>/<reservationNumber>", methods=["GET"])
@cross_origin(origin='localhost',headers=['Content- Type','Authorization'])
def autheticateUsers(user, destination, assetURI, reservationNumber) -> dict:
    "TODO SCRIVERE QUALCOSA A RIGUARDO"

    try:
        resHash=keccak.new(digest_bits=512)
        resHash.update(reservationNumber.encode('Utf8'))
        tx_hash=selfCheckInContract.functions.authenticateUsers(user,destination,assetURI,resHash.hexdigest()).transact({'from':minterAddress})
        tx_receipt = W3.eth.wait_for_transaction_receipt(tx_hash)
        return jsonify({"data": 'ok'}), 200
    except ValueError:
        return jsonify({"message": "Something went wrong. Please try again."}), 400


@APP.route("/selfcheckin/checkin/<user>/<destination>/<reservationNumber>", methods=["GET"])
@cross_origin(origin='localhost',headers=['Content- Type','Authorization'])
def checkIn(user,destination,reservationNumber) -> dict:
    "TODO"

    try:
        resHash=keccak.new(digest_bits=512)
        resHash.update(reservationNumber.encode('Utf8'))
        tx_hash=selfCheckInContract.functions.checkIn(user,destination,resHash.hexdigest()).transact({'from':minterAddress})
        tx_receipt = W3.eth.wait_for_transaction_receipt(tx_hash)
        return jsonify({"data": 'ok'}), 200
    except ValueError:
        return jsonify({"message": "Something went wrong. Please try again."}), 400

@APP.route("/selfcheckin/ischeckedin/<reservationNumber>", methods=["GET"])
@cross_origin(origin='localhost',headers=['Content- Type','Authorization'])
def ischeckedin(reservationNumber) -> dict:

    try:
        resHash=keccak.new(digest_bits=512)
        resHash.update(reservationNumber.encode('Utf8'))
        result=selfCheckInContract.functions.isCheckedIn(resHash.hexdigest()).call()
        return jsonify({"Checkin status": result }), 200
    except ValueError:
        return jsonify({"message": "Something went wrong. Please try again."}), 400


@APP.route("/selfcheckin/getdestination/<user>/<reservationNumber>", methods=["GET"])
@cross_origin(origin='localhost',headers=['Content- Type','Authorization'])
def getdestination(user,reservationNumber) -> dict:

    try:
        resHash=keccak.new(digest_bits=512)
        resHash.update(reservationNumber.encode('Utf8'))
        result=selfCheckInContract.functions.getDestination(user,resHash.hexdigest()).call()
        return jsonify({"hotel": result}), 200
    except ValueError:
        return jsonify({"message": "Something went wrong. Please try again."}), 400

@APP.route("/selfcheckin/getasset/<reservationNumber>", methods=["GET"])
@cross_origin(origin='localhost',headers=['Content- Type','Authorization'])
def getasset(reservationNumber) -> dict:

    try:
        resHash=keccak.new(digest_bits=512)
        resHash.update(reservationNumber.encode('Utf8'))
        result=selfCheckInContract.functions.getAsset(resHash.hexdigest()).call()
        return jsonify({"Asset URI": result}), 200
    except ValueError:
        return jsonify({"message": "Something went wrong. Please try again."}), 400

if __name__=="__main__":
    APP.run(host='127.0.0.1', port=4455, debug=True, ssl_context='adhoc') 
