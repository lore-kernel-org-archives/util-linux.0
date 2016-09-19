Return-Path: util-linux-owner@vger.kernel.org
Received: from vhrz24.hrz.uni-marburg.de ([137.248.1.34]:53108 "EHLO
        vhrz24.HRZ.Uni-Marburg.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbcISXmT (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 19 Sep 2016 19:42:19 -0400
Received: from [10.0.1.5] (pD9E3C426.dip0.t-ipconnect.de [217.227.196.38])
        (authenticated bits=0)
        by vhrz24.HRZ.Uni-Marburg.DE (8.14.4/8.14.4/Debian-8+deb8u1) with ESMTP id u8JNZVgq040111
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-SHA bits=128 verify=NOT)
        for <util-linux@vger.kernel.org>; Tue, 20 Sep 2016 01:35:33 +0200
From: Reuti <reuti@staff.uni-marburg.de>
Content-Type: text/plain; charset=us-ascii
Subject: `whereis` doesn't honor $MANPATH or command line argument -M as expected
Date: Tue, 20 Sep 2016 01:35:31 +0200
Message-Id: <3B7FDDAD-00C5-4D63-9687-971127B422A8@staff.uni-marburg.de>
To: util-linux <util-linux@vger.kernel.org>
Mime-Version: 1.0 (Apple Message framework v1085)
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

The `whereis` command is supposed to look also in $PATH and $MANPATH. While the $PATH lookup works as expected, I observe a glitch how $MANPATH or -M is handled:

The builtin man pages e.g. /usr/share/man will be expanded inside `whereis` as /usr/share/man/* to look into the individual sections man1, man2, ... This seems not to happen neither for the paths given in $MANPATH, nor the command line argument -M. While for the command line argument it might be a matter of discussion whether one prefers that it's necessary to specify /opt/chemsoft/man/man1 instead of just /opt/chemsoft/man, it's mandatory to have a setting of /opt/chemsoft/man in $MANPATH to get access to different sections of the man pages with the usual `man 1 mycommand` resp. `man 3 mycommand` from the individual subdirectories man1 and man3.

I would prefer that `whereis` looks in all the subdircetories of all the paths set in $MANPATH too.

(observed in the actual version util-linux-2.28)

-- Reuti