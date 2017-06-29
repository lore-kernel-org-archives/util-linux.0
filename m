Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:51475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751541AbdF2BbH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Jun 2017 21:31:07 -0400
Received: from tenfore.site ([92.195.15.151]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mecqq-1d6UtM3zpY-00OIkM for
 <util-linux@vger.kernel.org>; Thu, 29 Jun 2017 03:31:05 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: exit() vs _exit()
Date: Thu, 29 Jun 2017 03:31:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201706290331.04310.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I've noticed we have some exit() calls in the libs,

e.g. in exec_helper()

  libmount/src/context_mount.c
  libmount/src/context_umount.c

Is this really ok or shouldn't we use _exit() there?

cu,
Rudi
