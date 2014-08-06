Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:38851 "EHLO
	Ishtar.hs.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbaHFW72 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Aug 2014 18:59:28 -0400
Received: from [192.168.4.12] (athenae [192.168.4.12])
	by Ishtar.hs.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id s76MxQoD045825
	for <util-linux@vger.kernel.org>; Wed, 6 Aug 2014 15:59:29 -0700
Message-ID: <53E2B34F.6080601@tlinx.org>
Date: Wed, 06 Aug 2014 15:59:27 -0700
From: "Linda A. Walsh" <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Generic, per-fs and per-dev defaults in fstab?
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Split this off from previous note (different subject, though
forgot to change previous subject line fully! *arg*).


As another matter of being user friendly, why can't specify a defaults
line for all mounts with the option of per-type defaults taking precedence:

default   *     defaults     defaults,x-'"mostly for completeness"'
default   xfs   defaults     logbsize=256k,largeio,nodiratime
/dev/sdf  xfs   defaults     su=64k,sw=256k
...
-------------

fs-type specific mounts would be applied after global
defaults, and in the 3rd line, what I am trying
to allow for (some way to tell any future space
managers to pay attention to the above alignment --
i.e. mkfs would be sure to set such params for xfs,
lvm and partition managers _could_ both use that information
to align layout.... etc.  Obviously the work /util would
have to come over time, but setting up a standard place
for such information is necessary -- and the file-system table
seems like a logical place to describe file-volume and filesystem details.

THE main purpose behind defaults -- is to apply to interactively made 
mounts,
so a user can have some set of defaults they want to, by default,
be applied when they use a mount command interactively.
(It can save on typing when working w/multiple temporary mounts & 
filesystems).




