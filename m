Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:59976 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752507AbdGRJxA (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Jul 2017 05:53:00 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: uuidparse: test fails on 32bit machines
Date: Tue, 18 Jul 2017 11:52:36 +0200
Cc: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
References: <201707122115.01476.ruediger.meier@ga-group.nl> <20170718080709.s6fra6bgxkxd6f23@ws.net.home>
In-Reply-To: <20170718080709.s6fra6bgxkxd6f23@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201707181152.36773.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 18 July 2017, Karel Zak wrote:
> I have removed this dates from the test. The things are internally
> based on time_t (=long) and uint32_t. It does not make sense to use
> it for huge numbers.


FYI I have created two travis testing branches in my private github 
repo: https://travis-ci.org/rudimeier/util-linux/builds

  travis-cc-test
     - testing many different compilers versions, even using -Werror
     - gcc 4.6, 4.8, 5, 6 and 7
     - clang 3.4, 3.5, 3.9, 4.0 and 5.0
     - OSX xcode 6.4, 7.3, 8.3

  travis-cc-test
     - testing 32bit build, -m32 -Werror

These build matrices are too big and ugly for our master branch, but 
probably I will keep them in my private repo to run them 
regularly/automated. So now, because of -Werror, we can stop wasting 
time, reviewing again and again our major travis logs for compiler 
warnings, etc.

Regarding -Werror, see the env column of the currently latest build here
https://travis-ci.org/rudimeier/util-linux/builds/254776766

I have added a few -Wno-error=xyz flags for gcc 4.x (false positives). 
And also one for gcc-7 which might be worth to fix.

Note, my both branches above include open pull request #486:
https://github.com/karelzak/util-linux/pull/486

cu,
Rudi
