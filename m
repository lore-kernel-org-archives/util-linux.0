Return-Path: ingenit@zoho.com
Message-ID: <50B36456.7080009@zoho.com>
Date: Mon, 26 Nov 2012 13:45:10 +0100
From: =?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>,
        Andy Lutomirski <luto@amacapital.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH] Add no_new_privs
References: <b9e1a13168f41cde97e1fdaa21cdc5354ef535ea.1353702119.git.luto@amacapital.net> <50AFE72B.1010908@draigBrady.com> <20121126100822.GA4224@x2.net.home>
In-Reply-To: <20121126100822.GA4224@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 26/11/12 11:08, Karel Zak wrote:
>  I guess that there will be never one super util to set all the
>  possible properties (prlimit, personality, scheduler stuff, ....) and
>  I personally don't see problem to type
> 
>    setarch x86_64 --addr-no-randomize \
>    taskset --cpu-list 1,2 \
>    prlimit --nofile=1024:4095 \
>    nice -20 \
>    <myprog>

It may be a problem if the restrictions placed with one program are
incompatible with chaining another one.

For instance, I could want to run a static binary foo as:
 prlimit --nofile 1:1 /usr/local/bin/foo

But I won't be able to do
 prlimit --nofile 1:1 nice /usr/local/bin/foo
since nice wouldn't be able to open libc.

In this case nice can be called with prlimit as parameter, but you will
end up with some options provided by different binaries and which are
incompatible.

We probably can't avoid it, so go ahead with it. Make sure all these
tools have their man pages properly interlinked, though.
