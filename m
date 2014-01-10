Return-Path: luto@amacapital.net
Message-ID: <52D05C3F.6080806@mit.edu>
Date: Fri, 10 Jan 2014 12:46:55 -0800
From: Andy Lutomirski <luto@amacapital.net>
MIME-Version: 1.0
To: Kjetil Torgrim Homme <kjetil.homme@redhill-linpro.com>, kzak@redhat.com
CC: util-linux@vger.kernel.org
Subject: Re: flock(1): working with fcntl locks
References: <52C6C23E.1070207@redpill-linpro.com> <20140103144050.GA4435@x2.net.home> <52C6D365.10601@redpill-linpro.com> <20140104083107.GB4435@x2.net.home>
In-Reply-To: <20140104083107.GB4435@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 01/04/2014 12:31 AM, Karel Zak wrote:
> On Fri, Jan 03, 2014 at 04:12:37PM +0100, Kjetil Torgrim Homme wrote:
>>>  Welcome to POSIX/Linux locking... read nice Lennart's summary:
>>>  http://0pointer.de/blog/projects/locking.html
>>>  http://0pointer.de/blog/projects/locking2
>>
>> thanks!  doesn't seem relevant for flock(1), though, since there is no
>> threading involved.  flock(1) should acquire the lock, fork the child and
>> wait for it before returning the lock.  no pitfalls there?
> 
>        (
>           flock -n 9 || exit 1
>           # ... commands executed under lock ...
>        ) 9>/var/lock/mylockfile
> 
> this is way how people use flock in scripts and it works because it's 
> based on file descriptors and independent on original process.
> 
>> I don't see why you think fcntl(2) sucks more.
> 
>  see Lennart's summary, the problem is that the lock is based on
>  process and it's useless for system files (due to open/close 
>  in libraries), etc.
> 
>>>  No please, flock(1) is based on flock(2), that's all. The semantic
>>>  and all possible limitations are well known. I don't think we want to
>>>  make things more complicated.
>>
>> do you think we should have a posixlock(1)?  (if so, perhaps it would fit
>> better in coreutils rather than util-linux ...)
> 
>  Yep.
> 
>  Frankly, reliable fcntl locking requires a lot of code and extra lock
>  files (we use it for example in original mount for /etc/mtab).

FWIW, there are patches floating around on LKML (my pathetic crystal
ball says they'll be merged for 3.14 or 3.15 and maybe even make it into
POSIX) to add a new F_SETLKP64 that creates an fcntl lock that's
attached to the file descriptor.

Once that goes in, it might pay to add a --fcntl flag to flock(1) that
fails on older kernels.


--Andy
