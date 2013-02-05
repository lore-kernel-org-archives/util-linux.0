Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.nowcomputing.com ([54.247.101.249]:35459 "EHLO
	mail.nowcomputing.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925Ab3BERHI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 5 Feb 2013 12:07:08 -0500
From: Alejandro Martinez Ruiz <alex@nowcomputing.com>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
Subject: libblkid: add f2fs support
Date: Tue,  5 Feb 2013 18:00:05 +0100
Message-Id: <1360083607-29885-1-git-send-email-alex@nowcomputing.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

These patches implement support for Samsung's f2fs (Flash-Friendly File System)
in libblkid. f2fs was recently merged into the Linux kernel for the 3.8 release.

The first patch implements superblocks/f2fs.c and adds it to the build system,
while the second one adds a test image.

Thanks,
  Alex

