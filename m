Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:48980 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754567Ab3BGOnH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 7 Feb 2013 09:43:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1U3ShB-0007Ho-1t
	for util-linux@vger.kernel.org; Thu, 07 Feb 2013 15:43:25 +0100
Received: from 78-60-211-195.static.zebra.lt ([78.60.211.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Thu, 07 Feb 2013 15:43:25 +0100
Received: from grawity by 78-60-211-195.static.zebra.lt with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Thu, 07 Feb 2013 15:43:25 +0100
To: util-linux@vger.kernel.org
From: "Mantas M." <grawity@gmail.com>
Subject: lslocks =?UTF-8?B?4oCTICJmYWlsZWQgdG8gcGFyc2UgcGlkOiAnV1JJVEUnIg==?=
Date: Thu, 07 Feb 2013 16:42:55 +0200
Message-ID: <kf0ehe$q7h$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When one process is holding an exclusive lock on a file, and other
processes are waiting for the lock to be released, the contents of
/proc/locks look like this:

$ cat /proc/locks
1: FLOCK  ADVISORY  WRITE 431143 00:0f:6325223 0 EOF
1: -> FLOCK  ADVISORY  WRITE 405209 00:0f:6325223 0 EOF
1: -> FLOCK  ADVISORY  WRITE 399578 00:0f:6325223 0 EOF
1: -> FLOCK  ADVISORY  WRITE 434120 00:0f:6325223 0 EOF
2: FLOCK  ADVISORY  WRITE 359765 08:04:28180839 0 EOF
3: FLOCK  ADVISORY  WRITE 359765 08:04:28180837 0 EOF
4: POSIX  ADVISORY  WRITE 434729 08:04:8653261 0 EOF
4: -> POSIX  ADVISORY  WRITE 434737 08:04:8653261 0 EOF
5: FLOCK  ADVISORY  WRITE 359765 08:04:28180836 0 EOF
6: ...

If I try to run `lslocks`, it fails to parse the "->" lines and exits
with an error message:

    lslocks: failed to parse pid: 'WRITE'

Can be reproduced by:

touch foo & flock foo -c "sleep 100" & flock foo -c "sleep 100" &
touch foo & lckdo -w foo sleep 100 & lckdo -w foo sleep 100 &

-- 
Mantas Mikulėnas <grawity@gmail.com>

