

#       Motoko Bootcamp

Motoko Bootcamp 2023 https://github.com/motoko-bootcamp/motokobootcamp-2023
[KICK OFF EVENT] Motoko Bootcamp 2023 https://www.youtube.com/watch?v=61PoBldlm3E&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=13

##  Resources

- IC https://internetcomputer.org/docs/current/developer-docs/
- DFX https://internetcomputer.org/docs/current/references/cli-reference/dfx-parent
- Motoko https://internetcomputer.org/docs/current/motoko/main/motoko
- Motoko Types https://internetcomputer.org/docs/current/motoko/main/base/
- Motoko Quick Ref https://internetcomputer.org/docs/current/motoko/main/language-manual
- Motoko Style Guideline https://internetcomputer.org/docs/current/motoko/main/style

- Motoko playground https://m7sm4-2iaaa-aaaab-qabra-cai.ic0.app/
- Dfinity education repo https://github.com/orgs/DFINITY-Education/repositories
- Examples https://internetcomputer.org/samples/

- Troubleshooting https://internetcomputer.org/docs/current/developer-docs/backend/troubleshooting

- Helpers
  * https://github.com/hugoroussel
  * https://github.com/massimoalbarello
  * https://github.com/patnorris
  * https://github.com/wannesds
  * https://github.com/tiagoloureiro89

##  01

[230505 15:55 17:50] Day 1 https://github.com/motoko-bootcamp/motokobootcamp-2023/blob/main/daily_guides/day_1/GUIDE.MD

*A canister is a container* for:
* dApps (one or multiple canisters)
* Users call
   read  ('query'  -> no consensus -> unsecure -> 200ms)
   write ('update' -> consensus    -> secure ->   1-2s)
* WASM module (code / canister behavior)
* WASM pages (memory / canister state)

A module can be replaced independently of the memory, thus canisters can be
*upgraded without the loss of their data*.

Variables:
- let -> *immutable*
- var -> *mutable*
- =   -> *assignment* operator
- :=  -> *reassignment* operator

    var n = 5;
    n := 0;

Types: Bool, Nat, Int, Text
- Nat *unbounded* (no overflow possible) natural numbers (0 to inf)
- Int integers
- Bool booleans
- Text strings of unicode are chars

    let foo : Text = "Hello";
    var age : Nat = 20;
    var age = 20; // implicit typing (inference)
    let light_on : Bool = True;

Functions:
- *public* func foo()  -> can be accessed by external users or canisters
- *private* func foo() -> can only be called by the canister itself
- the *async* keyword before the return value indicate that the function needs
  some time to complete so the caller will have to wait

Candid:
- Composing services (like canisters) written in different languages is central
  to the vision of the Internet Computer. *Candid is an IDL* (Interface
  Description Language), it let a program written in one language communicate
  with another program written in another unknown language.

Interact with a canister:
Local / Main net canister via dfx (CLI)
    $ dfx canister              call <CANISTER_NAME_OR_ID> <FUNCTION_NAME> <ARGUMENT>
    $ dfx canister --network ic call <CANISTER_NAME_OR_ID> <FUNCTION_NAME> <ARGUMENT>
Via Candid UI
    $ cat ./dfx/local/canister_ids.json
    @ http://127.0.0.1:4943/?canisterId=<CANDID_UI_CANISTER_ID>&id=<CANISTER_ID>


[230505 18:05 20:05] IC deploy sample app tutorial  https://internetcomputer.org/docs/current/tutorials/deploy_sample_app

TODO
- ERROR "Unable to route management canister request deposit_cycles:
  SubnetNotFound" when trying to *transfer cycles* from one identity to another.
- Candid *icp0.io* sucks, use *ic0.app*
  https://a4gq6-oaaaa-aaaab-qaa4q-cai.raw.ic0.app/?id=f22bk-yaaaa-aaaal-acihq-cai
  https://a4gq6-oaaaa-aaaab-qaa4q-cai.raw.icp0.io/?id=f22bk-yaaaa-aaaal-acihq-cai

[230505 20:30 20:35] IC introduction https://internetcomputer.org/docs/current/developer-docs/
[230505 20:35 21:20] IC getting started https://internetcomputer.org/docs/current/developer-docs/setup/

- A *user principal* or *canister principal* can be assigned to a *controller*
  (highest role) or *custodian* (lower role) role.

[230505 21:30 22:30] SETUP DEV ENV

[230506 14:05 14:25] MO language Tour https://internetcomputer.org/docs/current/motoko/main/motoko

- an *actor* is an *autonomous* object that fully *encapsulates* its state and
  *communicates* with other actors only through asynchronous messages

[230506 14:25 16:30] MO basic concepts and terms https://internetcomputer.org/docs/current/motoko/main/basic-concepts

The *unit type ()* is a kind of *void*

    func foo() : async Text { … }
    func foo() : async () { … }

Explicit typing:

    let n : Nat = 1 : Nat;

Debug:
- *print*

    D.print("hello world"); // output a Text string
    D.print(debug_show(("hello", 42))) // convert values into Text

- *Prelude* library provides functions that are designed to help developers work
  with *incomplete code* without compromising the integrity of the code or
  causing errors during runtime using functions that type check during compile
  time but trap at runtime if executed: P.xxx(), P.nyi, P.unreachable()

- force an *unconditional trap* with user defined message:

    import Debug "mo:base/Debug";
    Debug.trap("oops!");

- *assertions*

    assert 1 > 0; // never traps

[230505 15:30 16:00] SETUP DEV ENV (vim filetype)

[230508 15:30 15:50] MO base modules https://internetcomputer.org/docs/current/motoko/main/base-intro

Import from the base library:

    import <LOCAL_MODULE_NAME> "<PATH/MODULE_BASENAME>";
    import D "mo:base/Debug";

Import from local directory
    import Types "./types"; // import types.mo

[230508 15:50 18:00] MO mutable state https://internetcomputer.org/docs/current/motoko/main/mutable-state

- Simulate a var-bound variable using a let-bound variable

    var x : Nat       = 0 ;
    let y : [var Nat] = [var 0] ;

- *Immutable* arrays

    let a : [Nat] = [1, 2, 3];

- High-order array-allocation function *Array.tabulate*

    func tabulate<T>(size : Nat,  gen : Nat -> T) : [T]

    let array1 : [Nat] = [1, 2, 3, 4, 6, 7, 8] ;

    let array2 : [Nat] = Array.tabulate<Nat>(7, func(i:Nat) : Nat {
        if ( i == 2 or i == 5 ) { array1[i] * i }       // change 3rd and 6th entries
        else { array1[i] }                              // no change to other entries
    }) ;

- Unlike immutable arrays, mutable arrays have *non-shareable* types

- *Mutable* array

    let a : [var Nat] = [var 1, 2, 3] ;

- Array allocation function *Array.init*

    func init<T>(size : Nat,  x : T) : [var T]

    var size : Nat = 5 ;
    let x : [var Nat] = Array.init<Nat>(size, 0);       // [0, 0, 0, 0, 0]

***>>>>>>>>>>> HERE <<<<<<<<<<<***
[230509 18:30 19:45] [DAY 1 | LECTURE] Motoko: Overview of a Repository. https://www.youtube.com/watch?v=wHLprUTVPPA&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=1

Svelte Motoko example
    https://github.com/dfinity/examples/tree/master/svelte/svelte-motoko-starter
    https://internetcomputer.org/samples

Frontend dir
- public/assets dir: files which need to have an HTML endpoint so that they can
  be referenced by other parts of the web app.
- entry file: in this case it is the template *index.html*. Then *main.js* adds
  the output from *App.svelte* into the body of this template.
- scripts: CLI scripts for saving time when working with the repo
- components: *Component Based Design* is a process built on dividing a user
  interface into a collection of manageable and reusable parts that are used to
  create an end result (page or app screen).
- store: files related to the client-side state (logged in user info that need
  to be accessible by all components as the user browses the app)

Svelte
- tuto https://svelte.dev/tutorial/basics
- doc https://svelte.dev/docs

    "dfx export identity .pim file"


[] [DAY 1 | LECTURE] Motoko: variables, types, functions & loops. https://www.youtube.com/watch?v=E3KGcXogeKs&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=10
[] [DAY 1 | LECTURE] How to use DFX to deploy canisters? https://www.youtube.com/watch?v=wtKpMjzOLvQ&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ

[] coding challenges

##  02

[] Day 2 https://github.com/motoko-bootcamp/motokobootcamp-2023/blob/main/daily_guides/day_2/GUIDE.MD

[] IC motoko vs rust https://internetcomputer.org/docs/current/developer-docs/backend/choosing-language
[] IC building smart contracts with Motoko https://internetcomputer.org/docs/current/developer-docs/backend/backend-tutorials/

[] MO concise overview https://internetcomputer.org/docs/current/motoko/main/overview
[] MO actors and async data https://internetcomputer.org/docs/current/motoko/main/actors-async

[] [DAY 2 | LECTURE] Motoko: Option, Switch/Case & List. https://www.youtube.com/watch?v=QfOgBEwHoNs&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=7
[] [DAY 2 | LECTURE] Motoko: Array & Generic types https://www.youtube.com/watch?v=AS2JOhYWfEI&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=9
[] [DAY 2 | LECTURE] Motoko: Char, Text & Iterators. https://www.youtube.com/watch?v=l-NITyRki_s&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=5
[] [DAY 2 | EVENT] Open Dev Mentor Hour 1 https://www.youtube.com/watch?v=URei9O8T4dg&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=19

[] coding challenges

##  03

[] Day 3 https://github.com/motoko-bootcamp/motokobootcamp-2023/blob/main/daily_guides/day_3/GUIDE.MD

[] IC candid https://internetcomputer.org/docs/current/developer-docs/backend/candid/
[] IC create your first app tutorial https://internetcomputer.org/docs/current/tutorials/create_your_first_app/

[] MO style guideline https://internetcomputer.org/docs/current/motoko/main/style
[] MO pattern matching https://internetcomputer.org/docs/current/motoko/main/pattern-matching
[] MO message inspection https://internetcomputer.org/docs/current/motoko/main/message-inspection

[] [DAY 3 | LECTURE] Frontend: How to interact with your canisters using JavaScript https://www.youtube.com/watch?v=LRGGyvGnT18&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=6
[] [DAY 3 | LECTURE] Motoko: Custom Type, Variants, Pattern Matching & Result Type. https://www.youtube.com/watch?v=oVI6r8pr8rE&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=22
[] [DAY 3 | LECTURE] Motoko: HashMap & CRUD https://www.youtube.com/watch?v=jMmex4Sxhqg&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=8

[] coding challenges

##  04

[] Day 4 https://github.com/motoko-bootcamp/motokobootcamp-2023/blob/main/daily_guides/day_4/GUIDE.MD

[] IC frontend https://internetcomputer.org/docs/current/developer-docs/frontend/
[] IC dapp design considerations https://internetcomputer.org/docs/current/developer-docs/backend/design-dapps
[] IC integrating with IC from external systems https://internetcomputer.org/docs/current/developer-docs/agents/

[] MO sharing data and behavior https://internetcomputer.org/docs/current/motoko/main/sharing
[] MO errors and options https://internetcomputer.org/docs/current/motoko/main/errors

[] [DAY 4 | LECTURE] Lecture: Identity & Authentication on the Internet Computer https://www.youtube.com/watch?v=jqNQQf6V6zg&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=14
[] [DAY 4 | LECTURE] Motoko: Cycle management, Error handling & Admin functionalities. https://www.youtube.com/watch?v=TxhjkuLCiDM&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=16
[] Motoko Bootcamp: How it's Going (Day 4 of 7) https://www.youtube.com/watch?v=USnVPjWki4E&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=18
[] [DAY 4 | LECTURE] Motoko: Heap, Stable memory & upgrades. https://www.youtube.com/watch?v=j0fTNGsTxIA&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=20

[] MO stable variable https://internetcomputer.org/docs/current/motoko/main/upgrades
[] MO verifying upgrade compatibility https://internetcomputer.org/docs/current/motoko/main/compatibility
[] MO stable memory https://internetcomputer.org/docs/current/motoko/main/stablememory

[] coding challenges

##  05

[] Day 5 https://github.com/motoko-bootcamp/motokobootcamp-2023/blob/main/daily_guides/day_5/GUIDE.MD

[] MO principals and caller identification https://internetcomputer.org/docs/current/motoko/main/caller-id
[] MO local objects and classes https://internetcomputer.org/docs/current/motoko/main/local-objects-classes

[] [DAY 5 | LECTURE] Motoko: UNLOCK the power of Bitcoin! https://www.youtube.com/watch?v=IWWcnPj1Dfo&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=4
[] [DAY 5 | LECTURE] Motoko: the END of oracles! https://www.youtube.com/watch?v=eKD5Ug6fXIw&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=12
[] [DAY 5 | LECTURE] Motoko: Heartbeat & Intercanister Calls https://www.youtube.com/watch?v=tyxpMhrTCck&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=23

[] coding challenges

##  06

[] Day 6 https://github.com/motoko-bootcamp/motokobootcamp-2023/blob/main/daily_guides/day_6/GUIDE.MD

[] IC periodic tasks https://internetcomputer.org/docs/current/developer-docs/backend/periodic-tasks

[] MO timers https://internetcomputer.org/docs/current/motoko/main/timers
[] MO heartbeats https://internetcomputer.org/docs/current/motoko/main/heartbeats

[] MO modules and imports https://internetcomputer.org/docs/current/motoko/main/modules-and-imports
[] MO managing cycles https://internetcomputer.org/docs/current/motoko/main/cycles

[] [DAY 6 | LECTURE] Security: double spending, randomness, time. https://www.youtube.com/watch?v=S5imKfzuRck&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=17
[] [DAY 6 | PRESENTATION] Azle & Kybra: Write contracts with Typescript or Python  https://www.youtube.com/watch?v=Z_v4ebLYxn4&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=21
[] [DAY 6 | LECTURE] Motoko: Packages & Testing https://www.youtube.com/watch?v=s0nQv8sNIAk&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=24
[] [DAY 6 | PRESENTATION] Debugging and Building with the IC Inspector https://www.youtube.com/watch?v=iBaLmHiTrOQ&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=27

[] coding challenges

##  07

[] IC reproductible canister builds https://internetcomputer.org/docs/current/developer-docs/backend/reproducible-builds
[] IC integrations (http, bitcoin...) https://internetcomputer.org/docs/current/developer-docs/integrations/

[] MO actor classes https://internetcomputer.org/docs/current/motoko/main/actor-classes
[] MO imperative control flow https://internetcomputer.org/docs/current/motoko/main/control-flow
[] MO structual equality https://internetcomputer.org/docs/current/motoko/main/structural-equality

[] [DAY 7 | PRESENTATION] Show Me The Money! https://www.youtube.com/watch?v=zMliTOLDFq0&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=15
[] [DAY 7 | EVENT] Closing Ceremony https://www.youtube.com/watch?v=arPwp9KZGy8&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=26
[] [DAY 7 | PRESENTATION] ICServices https://www.youtube.com/watch?v=3TfRQJz4PXE&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=28
[] [DAY 7 | PRESENTATION] IC Pipeline https://www.youtube.com/watch?v=176XUZ76_wM&list=PLeNYxb7vPrkhQN6-ps2krq5Un3xPD3vBQ&index=29

[] coding challenges

##  More

[] IC running in production https://internetcomputer.org/docs/current/developer-docs/production/
[] IC use cases https://internetcomputer.org/docs/current/developer-docs/use-cases/
[] IC security best practices https://internetcomputer.org/docs/current/developer-docs/security/
[] IC gas/cycles cost https://internetcomputer.org/docs/current/developer-docs/gas-cost
