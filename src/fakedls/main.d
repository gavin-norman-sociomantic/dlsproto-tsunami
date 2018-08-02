/*******************************************************************************

    Example main file running fake DLS node. Can be used to debug the
    protocol changes manually (in a more controlled environment).

    Copyright:
        Copyright (c) 2015-2017 dunnhumby Germany GmbH. All rights reserved.

    License:
        Boost Software License Version 1.0. See LICENSE.txt for details.

*******************************************************************************/

module fakedls.main;

/*******************************************************************************

    Imports

*******************************************************************************/

import ocean.transition;

import turtle.env.Dls;

import dlsproto.client.legacy.DlsConst;

import ocean.io.select.EpollSelectDispatcher;
import ocean.io.select.client.TimerEvent;
import ocean.core.MessageFiber;

import ocean.util.log.Logger;
import ocean.util.log.AppendConsole;

/*******************************************************************************

    Configure logging

*******************************************************************************/

static this ( )
{
    Log.root.add(new AppendConsole);
    Log.root.level(Level.Trace, true);
}

/*******************************************************************************

    Simple app that starts fake DLS and keeps it running until killed

*******************************************************************************/

version ( UnitTest ) {}
else
void main ( )
{
    auto epoll = new EpollSelectDispatcher;
    Dls.initialize("127.0.0.1", 10000, epoll);

    auto log = Log.lookup("fakedls.main");
    log.info("Registering fake node");
    dls.register(epoll);

    log.info(
        "Starting infinite event loop, kill the process if not needed anymore");
    epoll.eventLoop();
}
