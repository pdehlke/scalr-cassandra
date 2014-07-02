Casslr
======

Casslr is a support library to use Scalr with Cassandra. Functionally,
Casslr is similar to Netflix Priam:

  + One backend service (found under python/) is in charge of identifying
    seed nodes for Cassandra using Scalarizr's admin interface (`szradm`), and
    serving this list over HTTP (note: this agent should run as root to
    be able to communicate with `szradm`)
  + One embedded service (found under java/) implements a Cassandra
    SeedProvider. Its purpose is simply to call the backend service over
    HTTP and retrieve the list of seed nodes.

Casslr is designed to be compatible with Cassandra >= 2.0, so unlike Priam,
it does not perform token generation (which is no longer needed).
