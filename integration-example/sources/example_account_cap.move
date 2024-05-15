module example::account_example {
    use sui::object::{Self, UID};
    use sui::transfer::{Self};
    use sui::tx_context::{TxContext};
    use lending_core::account::{AccountCap};
    use lending_core::lending::{Self};

    struct MyStruct has key, store {
        id: UID,
        navi_account: AccountCap
    }

    fun init(ctx: &mut TxContext) {
        let cap = lending::create_account(ctx);
        transfer::share_object(MyStruct{id: object::new(ctx), navi_account: cap})
    }

    public fun example_function(_: &MyStruct) {
        abort 0
    }
}