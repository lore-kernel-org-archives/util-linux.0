Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24039 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753385Ab2HDPmN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 4 Aug 2012 11:42:13 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q74FgDA3024729
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Sat, 4 Aug 2012 11:42:13 -0400
Received: from [10.36.116.20] (ovpn-116-20.ams2.redhat.com [10.36.116.20])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q74FgB04008710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <util-linux@vger.kernel.org>; Sat, 4 Aug 2012 11:42:12 -0400
Message-ID: <501D42D2.6050904@draigBrady.com>
Date: Sat, 04 Aug 2012 16:42:10 +0100
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: suggestion to avoid erroneous lines in findmnt/lslocks/...
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There was a recent change in df in coreutils to sanitize output of paths:

http://git.sv.gnu.org/gitweb/?p=coreutils.git;a=commitdiff;h=3ed70fd

The essential issue fixed there is that control chars in a path will be
converted to '?' (this works in all locales), and doing so will mean
'\n' for example is not output. You could even consider this a potential
security improvement so that arbitrary users couldn't influence the
output of these commands for all users.

I suggest using the simple inplace replacement function from above.

cheers,
Pádraig.
