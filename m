Return-Path: util-linux-owner@vger.kernel.org
Received: from userp1040.oracle.com ([156.151.31.81]:49898 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965281AbcBCWC3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 3 Feb 2016 17:02:29 -0500
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: scsi_debug, iosize optimal < minimum
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <201601291131.29201.sweet_f_a@gmx.de>
	<201601291718.21185.sweet_f_a@gmx.de>
	<yq1fuxcr5lk.fsf@sermon.lab.mkp.net>
	<201602032255.44508.sweet_f_a@gmx.de>
Date: Wed, 03 Feb 2016 17:02:19 -0500
In-Reply-To: <201602032255.44508.sweet_f_a@gmx.de> (Ruediger Meier's message
	of "Wed, 3 Feb 2016 22:55:44 +0100")
Message-ID: <yq1a8nhlafo.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>>>>> "Ruediger" == Ruediger Meier <sweet_f_a@gmx.de> writes:

Ruediger> In past (kernel<=4.1) optimal_io_size io size was 32768. Is
Ruediger> this really correct now?

We recently bumped the scsi_debug optimal I/O size to something akin to
what real-world storage reports.

-- 
Martin K. Petersen	Oracle Linux Engineering
