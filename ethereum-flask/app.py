"""
Bootstrap flask application
"""

import os
import json
from eth_account import account
from web3 import Web3
from flask import Flask, jsonify
from web3.types import ParityTraceMode
from utils.block import transform_block
from utils.transaction import list_transactions, transform_transaction

APP = Flask(__name__)
URL = "http://127.0.0.1:7545" # blockchain server
W3 = Web3(Web3.HTTPProvider(URL))

contractAddress = "0xDe6198c869210D3C756AdaBE31458f5403Ae8A44"
script_dir = os.path.dirname(__file__)
file_path = os.path.join(script_dir, 'abi/abiToken.json')
standard_token_abi = json.load(open(file_path))
contract = W3.eth.contract(contractAddress, abi=standard_token_abi)
minterAddress = "0xbb052D09319ACCd7C65A8cAae95fCe00d63e7eF5"

#file di configurazione

@APP.route("/tx/<transid>", methods=["GET"])
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
        contract.functions.transfer(toAddress, W3.toWei(token_to_send, 'ether')).transact({'from': sendAddress})
        return jsonify({"data": 'ok'}), 200
    except ValueError:
        return jsonify({"message": "Something went wrong. Please try again."}), 400
        

@APP.route("/mint/<int:token>/<sendAddress>", methods=["GET"])
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


if __name__=="__main__":
    APP.run(host='127.0.0.1',port=4455,debug=True) 
