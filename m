Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45153 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972Ab1GLQV7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 12 Jul 2011 12:21:59 -0400
Received: by wwe5 with SMTP id 5so5114954wwe.1
        for <util-linux@vger.kernel.org>; Tue, 12 Jul 2011 09:21:58 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 12 Jul 2011 12:21:58 -0400
Message-ID: <CAAN0OpipdTBHfJGJG0s-YQQ0EbmrLzCkh6PWfHvVAdz78mFE6w@mail.gmail.com>
Subject: Error in man page for fstab
From: Brad Goodman <brad@bradgoodman.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The fstab man page contains the following text:

>> The third field, (fs_vfstype) ... An entry "none" is  useful  for bind or move mounts

"none" is interpreted as an actual vfstype, which does not have the
intended consequences.

I believe the word "none" should be replaced with "auto", which
automatically detects the vfstype.

This was seen under Centos 6.0, which gave the following info from the man page:
Linux 2.2          15 June 1999                         FSTAB(5)
