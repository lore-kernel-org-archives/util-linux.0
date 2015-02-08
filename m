Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40450 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758233AbbBHUUJ convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 8 Feb 2015 15:20:09 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id A3AFB20B76
	for <util-linux@vger.kernel.org>; Sun,  8 Feb 2015 15:20:08 -0500 (EST)
Message-Id: <1423426808.1949360.224667813.2ED36110@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: more nits in cfdisk
Date: Sun, 08 Feb 2015 21:20:08 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi,

Starting cfdisk with --zero, a message on the bottom bar says:
"Device does not contain a recognized partition table."
This is most likely not an accurate message in this situation,
so an upcoming patch suggests to differentiate between an
invocation with --zero and a normal invocation.

A second patch will suggest to also accept a lowercase 'l'
for loading a script file.  The Load command isn't dangerous,
as is the Write command, so there is no need to make it
somewhat more difficult to enter.


When cfdisk prompts for a script file name, the line that says
"Select a type..." should probably be cleared.  And maybe also
the menu of label types?

When the user enters a wrong name or some other error occurs,
probably the line that says "The script file will be applied..."
should be cleared.


When starting cfdisk with --zero and choosing the sun label type,
a bottombar message says: "Note that partition table entries are
not in disk order now."  The menu item "Sort" is present, but
using it has no effect.  Probably things have to be this way and
the message shouldn't be given for a Sun label?


When on my disk I recreate the extended partition sda4, and
then make two partitions of 11G and 12G (sda5 and sda6), and
then delete the first, things look like this:

    /dev/sda4               93755392  312581807  218826416  104,4G   5 Extended
>>  ├─Free space            93757440  116828160   23070721     11G              
    ├─/dev/sda5            116828160  141993983   25165824     12G  83 Linux
    └─Free space           141996032  312581807  170585776   81,3G

When I then recreate the 11G partition, things suddenly look like this:

    /dev/sda4               93755392  312581807  218826416  104,4G   5 Extended
>>  ├─/dev/sda5            116828160  141993983   25165824     12G  83 Linux    
    ├─Free space           141996032  312581807  170585776   81,3G
    └─/dev/sda6             93757440  116828159   23070720     11G  83 Linux

The newly created partition is listed at the end, and the cursor
is no longer pointing at the same part of the disk (the one with
start sector 93757440).  I find this confusing.  Why does cfdisk
not auto-sort the partitions so that they are always in disk order?

When I then create a third partition (sda7) of 13G, things look thus:

    /dev/sda4               93755392  312581807  218826416  104,4G   5 Extended
    ├─/dev/sda5            116828160  141993983   25165824     12G  83 Linux
>>  ├─/dev/sda6             93757440  116828159   23070720     11G  83 Linux    
    ├─/dev/sda7            141996032  169259007   27262976     13G  83 Linux
    └─Free space           169261056  312581807  143320752   68,3G

Now suddenly sda6 is not listed at the end any more.  There is
some sense to this, but it is not user-friendly.  For one thing: the
cursor should always point at the space/partition that was just
created, never at a different one.  And if there is free space
that stretches till the end of the disk, then never any partition
should be listed after it (as occurs in the above middle example).

Benno

-- 
http://www.fastmail.com - IMAP accessible web-mail

