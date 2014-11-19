Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:56423 "EHLO
	resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756971AbaKSWYr (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 19 Nov 2014 17:24:47 -0500
Date: Wed, 19 Nov 2014 17:24:43 -0500
Message-Id: <201411192224.sAJMOhTi010782@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Drake Wilson <drake@dasyatidae.net>
CC: util-linux@vger.kernel.org, 770211@bugs.debian.org
In-reply-to: <546D0495.2030803@dasyatidae.net> (drake@dasyatidae.net)
Subject: Re: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: Drake Wilson <drake@dasyatidae.net>
> 
> Summary: I would like to reopen the suggestion to add LUKS partition
> type codes for MBR and for GPT to util-linux's fdisk.

It certainly makes sense to me.

This raises the related question of whether there should be codes to
identify the partition type inside the LUKS partition.  That is, the
partition table code identifies the partition as a LUKS partition, but
once one has supplied the keys for LUKS encryption, is there any way
to tell the type of the encrypted partition without testing for magic
numbers (using "file" or the like)?

I suppose there aren't enough type codes in MBR to allow separately
identifying "ext4 inside LUKS", but with GPT it would be possible, and
even could be done systematically.  E.g., if the UUID for a partition
type is XXX, then the partition type for that type inside of LUKS is
MD5("LUKS" XXX)...

Then again, perhaps you would not want to reveal the type of the
encrypted partition.

Dale
