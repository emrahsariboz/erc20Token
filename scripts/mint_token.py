import math
from brownie import accounts, EmrahToken, config, network, Contract
from scripts.deploy import get_account


def mint_emr_token():
    print(EmrahToken[-1])

    # Get the most recent deployed contract!
    contract = EmrahToken[-1]

    # Mint 10 EMR Token
    transaction = contract.mint(10 * math.pow(10, 18), {"from": get_account()})

    # Wait till confirmed
    transaction.wait(1)

    # Print total supply
    print("Total supply is: ", contract.totalSupply())


def main():
    mint_emr_token()
