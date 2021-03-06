/*******************************************************************************

    Test for sending a set of records with non-sequential keys via Neo's Put

    Copyright:
        Copyright (c) 2016-2017 dunnhumby Germany GmbH. All rights reserved.

    License:
        Boost Software License Version 1.0. See LICENSE.txt for details.

*******************************************************************************/

module dlstest.cases.neo.UnorderedPut;

/*******************************************************************************

    Imports

*******************************************************************************/

import dlstest.NeoDlsTestCase;
import dlstest.DlsClient;

/*******************************************************************************

    Checks that a set of records with non-sequential keys written to the DLS via
    Put are correctly added to the database.

*******************************************************************************/

class UnorderedPutTest : NeoDlsTestCase
{
    import dlstest.util.LocalStore;
    import dlstest.util.Record;

    public override Description description ( )
    {
        Description desc;
        desc.name = "Neo Unordered Put test";
        return desc;
    }

    public override void run ( )
    {
        LocalStore local;

        for ( uint i = 0; i < bulk_test_record_count; i++ )
        {
            auto rec = Record.spread(i);
            this.dls.neo.put(this.test_channel, rec.key, rec.val);
            local.put(rec.key, rec.val);
        }

        local.verifyAgainstDls(this.dls, DlsClient.ProtocolType.Neo,
                this.test_channel);
    }
}

