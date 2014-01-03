Return-Path: util-linux-owner@vger.kernel.org
Received: from gallus.zimbra.h.bitbit.net ([87.238.49.226]:28369 "EHLO
	gallus.zimbra.h.bitbit.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751931AbaACPMm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 3 Jan 2014 10:12:42 -0500
Message-ID: <52C6D365.10601@redpill-linpro.com>
Date: Fri, 03 Jan 2014 16:12:37 +0100
From: Kjetil Torgrim Homme <kjetil.homme@redpill-linpro.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: flock(1): working with fcntl locks
References: <52C6C23E.1070207@redpill-linpro.com> <20140103144050.GA4435@x2.net.home>
In-Reply-To: <20140103144050.GA4435@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 03/01/2014 15:40, Karel Zak wrote:
> On Fri, Jan 03, 2014 at 02:59:26PM +0100, Kjetil Torgrim Homme wrote:
>> I was a bit surprised to find that flock(2) specifically ignores fcntl
>> locks.  from its manual page:
>>
>>         Since  kernel  2.0,  flock() is implemented as a system call in its
>> own
>>         right rather than being emulated in the GNU C  library  as a  call
>> to
>>         fcntl(2).   This  yields  true  BSD  semantics: there is no
>> interaction
>>         between the types of lock placed by flock() and fcntl(2), and
>> flock()
>>         does not detect deadlock.
>   Welcome to POSIX/Linux locking... read nice Lennart's summary:
>   http://0pointer.de/blog/projects/locking.html
>   http://0pointer.de/blog/projects/locking2

thanks!  doesn't seem relevant for flock(1), though, since there is no 
threading involved.  flock(1) should acquire the lock, fork the child 
and wait for it before returning the lock.  no pitfalls there?

>> I was trying to check if dpkg or apt-get was holding its lock and skip
>> running my cron job if so, but unfortunately it uses fcntl (F_SETLK), and
>> flock(1) will happily call flock(2) which succeeds.
>>
>> it's a bit sad to have to write the lock testing in C or Perl rather than
>> use the nice little flock(1), so I wonder if we could "fix" flock(1)
>> somehow.  I think I'm not alone to be surprised that flock(1) is so
>> ineffective against locking done by other utilities, so my prefered solution
>> would be to switch to using fcntl(2).
>   Sorry, but today is not 1st Apr ;-)
>   
>   And process based fcntl(2) sucks more than flock(2) and for things like
>   flock(1) it's probably completely useless.

I don't see why you think fcntl(2) sucks more.  it is more portable and 
more versatile, and therefore most applications use that instead of 
flock(2).  as mentioned earlier, flock(2) is a relatively new invention, 
it used to be flock(3) which called fcntl(2) via a compatibility layer.

>> the chance of a problematic regression is small, I think.  my *guess* is
>> that most flock(1) usage is only interacting with other usage of flock(1)
>> (not flock(2)).  also relying on flock(1) succeeding on a fcntl-locked file
>> would be just Wrong(tm).
>>
>> the "safe" solution is to add a flag, --fcntl, but isn't that just cruft?
>>
>> I can provide patches when I hear what the mailing list wants.
>   No please, flock(1) is based on flock(2), that's all. The semantic
>   and all possible limitations are well known. I don't think we want to
>   make things more complicated.

do you think we should have a posixlock(1)?  (if so, perhaps it would 
fit better in coreutils rather than util-linux ...)

-- 
Kjetil T. Homme
Redpill Linpro - Changing the game

