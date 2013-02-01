Return-Path: hgb@ifi.uio.no
MIME-version: 1.0
Content-type: text/plain
From: Henrik Grindal Bakken <hgb@ifi.uio.no>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: login/telnet problems
References: <x2efw1iyk1r.fsf@diamant.ifi.uio.no>
 <20130201163102.GJ3741@x2.net.home>
Date: Fri, 01 Feb 2013 18:29:07 +0100
In-reply-to: <20130201163102.GJ3741@x2.net.home>
Message-id: <m3boc4eye4.fsf@morag.moria.no>
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@redhat.com> writes:

> On Wed, Jan 30, 2013 at 12:41:52PM +0100, Henrik Grindal Bakken wrote:
>> Hi.  I'm working on a product which (sadly) requires telnet, and after
>> an upgrade from util-linux-2.20 to 2.22.2, telnet starts acting up by
>> dropping the first character (at least that's the easiest problem to
>> spot).
>
> Seems like a kernel problem: https://lkml.org/lkml/2013/1/15/641

How fascinating!  It didn't even remotely occur to me that a (seemingly)
login/telnet problem was kernel-related...

>> It's not a huge problem for me to keep a local revert of this commit,
>> but I thought perhaps you wanted to know it did actually break
>> something (although one can argue the very existence of telnet these
>> days is a bug...).
>
> In https://bugzilla.redhat.com/show_bug.cgi?id=904182 someone
> suggested -D for telned as workaround :-)

Hmm.  I'll stick with my util-linux patch for now, I think.  I'll follow
the development on the kernel bug, though.  Thanks a bunch.

I actually tried using different -D options to telnet, and noticing that
some of them actually fixed the problem, but that gave me debug output
on the telnet client, which wasn't really acceptable...

-- 
Henrik Grindal Bakken <hgb@ifi.uio.no>
PGP ID: 8D436E52
Fingerprint: 131D 9590 F0CF 47EF 7963  02AF 9236 D25A 8D43 6E52
