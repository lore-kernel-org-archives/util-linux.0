Return-Path: util-linux-owner@vger.kernel.org
Received: from enyo.dsw2k3.info ([195.71.86.239]:35578 "EHLO enyo.dsw2k3.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932074Ab2B1Ooj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Feb 2012 09:44:39 -0500
Date: Tue, 28 Feb 2012 15:44:26 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: What about a premount/postumount option for mount?
Message-ID: <20120228144426.GA5351@citd.de>
References: <20120211123016.GA15097@citd.de>
 <20120228135918.GB22034@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120228135918.GB22034@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 28.02.2012 14:59, Karel Zak wrote:
> On Sat, Feb 11, 2012 at 01:30:16PM +0100, Matthias Schniedermeyer wrote:
> > This solution would also make for e.g. "loop-aes" more easily usable, 
> > currently one has to use a patched version of mount/losetup. With a 
> 
>  Do you know that the latest cryptsetup is able to map loop-aes images
>  by dm-crypt?

Which is exactly the problem i'm trying to solve:
Moving from loop-aes to dm-crypt, without reencrypting the discs and 
retaining "autofs"ability.
The latter, as far as i can determine, is currently not possible without 
patching something.

On my test-machine i build a crude version of "premount/postumount". I 
did that by "diverting" (A Debian specific package-manager thing) 
/bin/mount to /bin/mount.orig (Same for umount) and putting a 
shell-script for /bin/mount that checks for /dev/mapper/... and sets it 
up on mount and then execs /bin/mount.orig. Same for umount, only it 
does the "loopaesClose" after running umount.orig.

This solution works more or less satisfactory, only the robustness isn't 
optimal.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

