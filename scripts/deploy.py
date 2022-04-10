from brownie import accounts, EmrahToken, config, network


def main():
    deploy()


def deploy():
    account = get_account()
    EmrahToken.deploy({"from": account})


def get_account():

    if network.show_active() == "development":
        return accounts[0]
    else:
        return accounts.add(config["wallet"]["from_key"])
