Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:62711 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965201AbcBDKrR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 4 Feb 2016 05:47:17 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: scsi_debug, iosize optimal < minimum
Date: Thu, 4 Feb 2016 11:47:09 +0100
Cc: util-linux@vger.kernel.org
References: <201601291131.29201.sweet_f_a@gmx.de> <201602032255.44508.sweet_f_a@gmx.de> <yq1a8nhlafo.fsf@sermon.lab.mkp.net>
In-Reply-To: <yq1a8nhlafo.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201602041147.09865.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 03 February 2016, Martin K. Petersen wrote:
> >>>>> "Ruediger" == Ruediger Meier <sweet_f_a@gmx.de> writes:
>
> Ruediger> In past (kernel<=4.1) optimal_io_size io size was 32768. Is
> Ruediger> this really correct now?
>
> We recently bumped the scsi_debug optimal I/O size to something akin
> to what real-world storage reports.

Regarding these kernel changes I've send a pull request via github to 
fix the tests:
https://github.com/karelzak/util-linux/pull/272

cu,
Rudi
