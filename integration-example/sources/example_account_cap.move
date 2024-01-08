module example::account_example {
    use sui::object::{Self, UID};
    use sui::clock::{Clock};
    use sui::transfer::{Self};
    use sui::tx_context::{TxContext};
    use lending_core::account::{AccountCap};
    use lending_core::lending::{Self};

    use lending_core::pool::{Pool};
    use sui::coin::{Coin};
    use lending_core::incentive::{Incentive as IncentiveV1};
    use lending_core::incentive_v2::{Self as incentive_v2, Incentive as IncentiveV2};
    use lending_core::storage::{Storage};

    struct MyStruct has key, store {
        id: UID,
        navi_account: AccountCap
    }

    fun init(ctx: &mut TxContext) {
        let cap = lending::create_account(ctx);
        transfer::share_object(MyStruct{id: object::new(ctx), navi_account: cap})
    }

    public fun deposit<CoinType>(me: &MyStruct, clock: &Clock, storage: &mut Storage, pool: &mut Pool<CoinType>, asset: u8, deposit_coin: Coin<CoinType>, incentive_v1: &mut IncentiveV1, incentive_v2: &mut IncentiveV2) {
        incentive_v2::deposit_with_account_cap(clock, storage, pool, asset, deposit_coin, incentive_v1, incentive_v2, &me.navi_account)
    }
}