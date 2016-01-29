Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:53092 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932381AbcA2QSl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 29 Jan 2016 11:18:41 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: scsi_debug, iosize optimal < minimum (was: test sfdisk, optimal_iosize)
Date: Fri, 29 Jan 2016 17:18:20 +0100
Cc: util-linux@vger.kernel.org,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Douglas Gilbert <dgilbert@interlog.com>
References: <201601291131.29201.sweet_f_a@gmx.de> <20160129113110.o76pvon3wormblgd@ws.net.home> <201601291402.14306.sweet_f_a@gmx.de>
In-Reply-To: <201601291402.14306.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201601291718.21185.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I've noticed a possible problem with scsi_debug devices where
optimal_io_size < minimum_io_size.

The problem seems reproducable with kernel 4.4.0 and also with
stable version 4.1.15. For stable tree the last known working
version is 4.1.13.

How to reproduce:

uname -mr
modprobe -r scsi_debug 
modprobe scsi_debug dev_size_mb=100 sector_size=512
udevadm settle
devname=$(grep --with-filename scsi_debug /sys/block/*/device/model | awk -F '/' '{print $4}')
cat /sys/block/$devname/queue/{minimum_io_size,optimal_io_size}
modprobe -r scsi_debug


## output kernel 4.1.13 (openSUSE Leap):
4.1.13-5-default x86_64
512
32768


## output kernel 4.1.15 (openSUSE Leap):
4.1.15-8-default x86_64
512
64

cu,
Rudi
