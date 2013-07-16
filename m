Return-Path: util-linux-owner@vger.kernel.org
Received: from mx.treblig.org ([80.68.94.177]:33077 "EHLO mx.treblig.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755071Ab3GPXyi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Jul 2013 19:54:38 -0400
Date: Wed, 17 Jul 2013 00:20:33 +0100
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: util-linux@vger.kernel.org
Cc: rleigh@debian.org, kzak@redhat.com
Subject: a repeatable 'more' crash and question about wide char and
 'get_line' safety
Message-ID: <20130716232033.GD9944@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,
  I've got a repeatable (for me!) crash in 'more' in git
( 5d3da4a24d0f952eb3709ba62c74aaa04729e08f ) that's also in at least 2.23.1 -
and I don't know how much older.

I believe the problem relates to the way the Line buffer is managed
in get_line; but more of the diagnosis below.

The problem:
------------

*** Error in `/usr/bin/more': free(): invalid pointer: 0x000000000060f850 ***

This was generated on OpenSuse 'factory' with their 2.23.1-4.3.x86_64
package, but then verified it on the current util-linux git.
Here is the bug I filed in their system:

https://bugzilla.novell.com/show_bug.cgi?id=829720

With the following test file:
https://bugzilla.novell.com/attachment.cgi?id=548234

(It's a fragment of /var/lib/rpm/Packages that I was
stupid enough to more).

The seg triggers in an 86x25 terminal for me just with

more tstfile2

It needs a UTF-8 LANG, I'm running with en_GB.UTF-8 but en_US.UTF-8 also
triggers it.

My original test triggered an invalid free check, but with the help
of valgrind I narrowed it down to:

==22488== Invalid write of size 1
==22488==    at 0x4037A2: get_line (more.c:1043)
        if (colflg && eatnl && Wrap) {
                *p++ = '\n';    /* simulate normal wrap */
        }
==22488==    by 0x4066C3: screen (more.c:660)
==22488==    by 0x4025E4: main (more.c:503)
==22488==  Address 0x542c318 is 0 bytes after a block of size 344 alloc'd
==22488==    at 0x4C297AB: malloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-lin

Answers/questions
-----------------

I've put a load of debug in and have some answers/questions:

   1) The loop in get_line() is:
        while (p < &Line[LineLen - 1]) {

     if I understand correctly that would seem to imply that if the loop
     always wrote no more than 1 character per iteration there should be 1
     space left in Line when you hit the bottom; of the loop, one for the
     \n in the code above that writes the '\n' sometimes....  but then
     it always writes a \0 on the end as well - so whenever we tack on
     a \n I think we overflow with the \0 if we're right at the end.

   2) unfortunately there are cases where the loop writes more than 1
   char per iteration; looking at:

http://git.kernel.org/cgit/utils/util-linux/util-linux.git/tree/text-utils/more.c#n874

     we see that the wide character code can take it's (size_t)-1 case,
     write a character and then it GOTO's (*) process_mbc: and hopefully
     lands in the default case and writes some characters in it's else
     clause; (in this test case 1) - but that loop worries me that it's
     possible to write more than one.

So hmm, what's the fix? 

    a) I think that loop limit needs to be at least LineLen - 2 just to
    cope with the \n and \0 case;  and there is also at least one inner
    loop (for tabs) that also has that loop limit coded in it that needs
    to match

    b) If we knew what the worst case was for the number of characters
    the WIDECHAR stuff could write then we could make the loop termination
    condition would then leave enoguh space for an entire widechar.

    c) Do we also need to change the allocation code in prepare_line_buffer?

It has:
              size_t nsz = Mcol * 4;

     Now that magic 4 isn't commented, but I'm currently guessing as
     it being the answer of (b) above - ie the size of a widechar?
     If so then I think it needs at least a +2 for the \n and \0

Dave (who doesn't know multi byte/wide stuff)


* Please hand Dijkstra a muffin
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\ gro.gilbert @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
