Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-08v.sys.comcast.net ([96.114.154.167]:37940 "EHLO
	resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750992AbbDNCxe (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Apr 2015 22:53:34 -0400
From: worley@alum.mit.edu (Dale R. Worley)
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: szx@live.ru, util-linux@vger.kernel.org
Subject: Re: Fix partition order killed my hard drive (twice)
In-Reply-To: <201504131227.45506.sweet_f_a@gmx.de>
Date: Mon, 13 Apr 2015 22:53:31 -0400
Message-ID: <87fv838lp0.fsf@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ruediger Meier <sweet_f_a@gmx.de> writes:
> First I would try to boot via rescue CD or similar. 
> Then check how the partitiontable looks now (fdisk -l) and try to mout 
> partitions manually. If you are missing partitions or if you just can't 
> mount them then you may try to repair/recover the partition table.  

If your partition table is damaged, it's possible to scan the disk
looking for the "magic numbers" that signal the start of partitions, and
reconstruct where the partitions are using that information.  (I've done
it myself.)

Dale
