Return-Path: util-linux-owner@vger.kernel.org
Received: from hapkido.dreamhost.com ([66.33.216.122]:54712 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933166Ab1CaPAM (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 31 Mar 2011 11:00:12 -0400
Received: from homiemail-a37.g.dreamhost.com (caiajhbdcbbj.dreamhost.com [208.97.132.119])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 3ABC717A4A2
	for <util-linux-ng@vger.kernel.org>; Thu, 31 Mar 2011 08:00:11 -0700 (PDT)
Subject: [RFC PATCH 0/3] mkfs.minix: add v3 support
From: Davidlohr Bueso <dave@gnu.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux-ng <util-linux-ng@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 31 Mar 2011 11:59:24 -0300
Message-ID: <1301583564.2159.14.camel@offworld>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

The following patches add support for the minix3 filesystem in
mkfs.minix. I have been able to successfully try this out on different
disks, loading different types of files (images, text, video, etc.). I
have also verified that stat(2) works fine on this and the regression
tests for util-linux pass. Since I am not a fs expert please try this
out thoroughly and let me know your opinion. Despite the ugliness of the
code (for years now), I tried not to be too invasive and not rewrite
large parts of it.

With this new version we can
* have up to 60 characters for filenames.
* specify the block size to be used.

Additionally, four options were added:
* -1, -2, -3 to specify what version of the fs to create
* -B to specify the block size

Thanks,
Davidlohr 

