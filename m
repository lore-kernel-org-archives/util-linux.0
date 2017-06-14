Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:64633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750728AbdFNKnQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 14 Jun 2017 06:43:16 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MLNeQ-1dLdjO4A8A-000cui for <util-linux@vger.kernel.org>; Wed, 14 Jun 2017
 12:43:14 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: partx: deleting single partitions fails
Date: Wed, 14 Jun 2017 12:43:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201706141243.11785.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

Looks like since commit 2d47fa39 partx does not understand
single partition numbers anymore.

$ partx 2 /dev/sdb
partx: partition and disk name do not match

$ partx -d 2 /dev/sdb
partx: partition and disk name do not match

We are using the last syntax in test "delete-non-existent" but do not 
check stderr.

cu,
Rudi
