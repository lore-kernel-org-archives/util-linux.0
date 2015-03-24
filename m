Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:50719 "EHLO
	resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752175AbbCXDYu (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Mar 2015 23:24:50 -0400
From: worley@alum.mit.edu (Dale R. Worley)
To: Ronan CHAUVIN <ronan.chauvin@parrot.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [libfdisk]: gpt_write_disklabel function robustness to sudden power
 off
In-Reply-To: <550BF3A9.8080508@parrot.com> (ronan.chauvin@parrot.com)
Date: Mon, 23 Mar 2015 23:24:45 -0400
Message-ID: <87384vyt4y.fsf@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ronan CHAUVIN <ronan.chauvin@parrot.com> writes:
> I was wondering if the gpt_write_disklabel function was robust to sudden 
> power-off.

gpt_write_disklabel can only be "robust to sudden power-off" if there is
some expectation that the partition tables, etc. can be in some sort of
"consistent" state if power is lost.  But it seems to me that there is
no such consistent state -- what condition would you want that
information to be in?  The old information is irretrevably lost during
the operation; the only problem that can be caused by sudden power-off
is that you have to enter the new information into fdisk again before
the disk has a valid structure.

Dale
