Return-Path: util-linux-owner@vger.kernel.org
Received: from vhrz24.HRZ.Uni-Marburg.DE ([137.248.1.34]:49871 "EHLO
	vhrz24.HRZ.Uni-Marburg.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbbG2PFN convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 29 Jul 2015 11:05:13 -0400
Received: from ma15106.chemie.uni-marburg.de (ma15106.Chemie.Uni-Marburg.DE [137.248.150.142])
	(authenticated bits=0)
	by vhrz24.HRZ.Uni-Marburg.DE (8.14.3/8.14.3/Debian-9.4) with ESMTP id t6TEscQj025438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <util-linux@vger.kernel.org>; Wed, 29 Jul 2015 16:54:39 +0200
From: Reuti <reuti@staff.uni-marburg.de>
Content-Type: text/plain; charset=us-ascii
Subject: hexdump: default output format is not -x
Message-Id: <BC43BDB2-1CA2-4A85-A919-0C905AF00E41@staff.uni-marburg.de>
Date: Wed, 29 Jul 2015 16:54:38 +0200
To: util-linux@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

the man page of the actual version 2.26.2 states:

"If no format strings are specified, the default display is equivalent to specifying the -x option."


But:

The format for -x in the source: add_fmt("\"%07.7_ax \" 8/2 \"   %04x \" \"\\n\"", hex);

The format without given option: add_fmt("\"%07.7_ax \" 8/2 \"%04x \" \"\\n\"", hex);


Although they are very alike, the different spacing can confuse users when reading the man page and trying to understand the different options. I suggest to either update the man page, or fix the source hexdump.c line 146, so that the default output is really -x or vice versa.

Personally I dislike the many spaces one gets with -x and would prefer the default format string also for -x.

-- Reuti