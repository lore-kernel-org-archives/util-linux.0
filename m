Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:32914 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeHZVxM (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 26 Aug 2018 17:53:12 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id w7QHsnef074673
        for <util-linux@vger.kernel.org>; Sun, 26 Aug 2018 10:54:52 -0700
Message-ID: <5B82E969.6090409@tlinx.org>
Date: Sun, 26 Aug 2018 10:54:49 -0700
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: RFD: --enable-bindir-path ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Was wondering about the addition of an "enable-bindir-path" which would 
only use
paths with /bin instead of /usr/bin for setups where /usr/bin -> /bin 
(like cygwin who mounts /bin and /lib on /usr/bin and /usr/lib -- using 
mounts instead of symlinks).  The've had that since the beginning with 
nothing being
installed in /usr/bin or /usr/lib.

Was also wondering why that wasn't chosen as a default for merging, since
/bin and /lib are almost always on the root file system so they are always
there, versus /usr/{bin,lib{,64}} which may need to be mounted before it can
be used...if it can't be mounted, having things in /bin & /lib pointed
to /usr won't work so well.

Anyway, just thought the option would be easy enough apart from other 
issues(?).
