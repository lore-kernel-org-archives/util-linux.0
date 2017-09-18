Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755447AbdIRJlC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 18 Sep 2017 05:41:02 -0400
Date: Mon, 18 Sep 2017 11:40:56 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: J William Piggott <elseifthen@gmx.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/4] logger: fix memory leaks [asan]
Message-ID: <20170918094056.gfqiul6xqvlxjhhf@ws.net.home>
References: <20170911195717.817-1-kerolasa@iki.fi>
 <20170911195717.817-3-kerolasa@iki.fi>
 <20170915110547.7znrzkpd7wf3mmdq@ws.net.home>
 <c51ca22c-801a-1711-144a-aba8d008bb18@gmx.com>
 <CAG27Bk3e3na7G_VTEC1vqOP5=pJrKePo-2y9=_qf28o92W7BjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3e3na7G_VTEC1vqOP5=pJrKePo-2y9=_qf28o92W7BjA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 16, 2017 at 08:31:27AM +0100, Sami Kerola wrote:
> Compiled with these:
> 
> export CC=clang
> export CFLAGS='-fsanitize=address -ggdb'
> export ASAN_SYMBOLIZER_PATH=/usr/bin/llvm-symbolizer

An idea for the next release v2.32:

 * add a new --enable-clang-asan to ./configure
 * add a new --asan option to tests/run.sh
 * rename tests/run.sh --memcheck to --valgrind 
 * rename tests/functions.sh:ts_valgrind() to ts_run()
 * improve ts_run() to be sensitive to --asan or --valgrind (etc.)
 * use export ASAN_OPTIONS='detect_leaks=0' by default
 * add TS_ENABLE_MEMLEAK_CHECK=yes to tests where we want to check for
   memory leaks (library tests, daemons, etc.)


and then we can use

    $ ./configure --enable-clang-asan
    $ cd tests
    $ ./run.sh --asan

to be sure we're without memory corruptions or relevant memory leaks.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
