Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751665AbcLHMHr (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 8 Dec 2016 07:07:47 -0500
Date: Thu, 8 Dec 2016 13:07:45 +0100
From: Karel Zak <kzak@redhat.com>
To: Whilom Chime <whilom.chime@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Fwd: In the "stupid" questions department...
Message-ID: <20161208120745.hpxf6nzdx3bw2n7o@ws.net.home>
References: <CAKSbvH9mE7YjyERuFusVJi0rbN1zdXCk9+=D7o0k5f3gTE+w-Q@mail.gmail.com>
 <CAKSbvH8mtBu--3jRe41Hiq=ubwEMU4riRG9q4QxoFtY-o1a-Pw@mail.gmail.com>
 <20161207190356.lfxyogrc6gelhryl@ws.net.home>
 <CAKSbvH_9JyNNL-K+8oU1=+45aM+cgcG4fvAEKcAcXOawrNDBEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKSbvH_9JyNNL-K+8oU1=+45aM+cgcG4fvAEKcAcXOawrNDBEw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 07, 2016 at 02:41:14PM -0500, Whilom Chime wrote:
> > We do not use _rcN there, it's X.Y release number, during -rc time
> > it's unstable and modifiable.
> 
> Could you just help me understand how lib??.sym works?  If I have 2.29
> source and I add UUID_2.30 {...}... does that mean that the symbol
> would be added in my local 2.29 build for testing, but once my
> hypothetical patch was accepted the "world" would not see my new APIs
> in any version less than 2.30?  Or does the package maintainer have to
> manually maintain all kinds of lib??.sym files as revisions happen...

The .sym is used to generate symbol names for the library. The
ELF format supports symbols versioning, see for example:

    $ readelf -a /lib/libuuid.so.1

we have for example

    uuid_compare@@UUID_1.0
    uuid_generate_time_safe@@UUID_2.20

the symbols and versions are evaluated when you execute an application
linked with the library. This allows to mix applications and libs
without recompilation until the library provides necessary symbols.

For more details see "3 Maintaining APIs and ABIs" from
https://software.intel.com/sites/default/files/m/a/1/e/dsohowto.pdf

It's independent on package version, it's possible to use arbitrary
strings as a version in the .sym files.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
