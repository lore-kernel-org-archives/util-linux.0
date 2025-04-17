Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FE01C84AD
	for <util-linux@vger.kernel.org>; Thu, 17 Apr 2025 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883353; cv=none; b=H6qlunsnbGUSvgmE8K+E2E2pz3DzXm+QBzDbD7oJkXM6S+WbM58ZpuYVebXgms4G6TE8ezCkV8V86tFn0s8htCBaShzVv6XHf+jUg+drNum0xJ1NQIZlZ6QZIyA8piCmlnEJYWzRRRgl2XAOTazvJXqrTqmlv/4CxsOvyRedz8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883353; c=relaxed/simple;
	bh=m5omdOJafuRszlfk9g+82IF++/bQXwsRfrVgkh3mR7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8e+DUwf273J1mK1oeymrMlu8ayHI8/OIeS6C2gD21IkjVz785v7eypuR1uQPuU6GA0KrNHmKawiial9FUjHijYNdE5x000xIgxshDyMJr3OGqm9F8IXq+VwaEw5xQPIHI9HJffvavV+RDFhLnRUcXYzO6dMzyfbarsszDluzDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=bENi03SZ; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="bENi03SZ"
X-KPN-MessageId: 555b6d80-1b71-11f0-8ec8-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 555b6d80-1b71-11f0-8ec8-005056994fde;
	Thu, 17 Apr 2025 11:50:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=562VxIOzaaRmf66s/RTx06+K2nlWN//NWE97b7cXqoo=;
	b=bENi03SZBZEXkiC6fnvIb0+8GAH/OIN35vj10NqUTVTuHoRPwDei1elNyHf7tjyvNvR49M68CIOO7
	 UrrU61EZHaWsGxSyfCPy1V1bhy7shNaRPabk80iItcYqmttwFB5C8F+mMLJ3Yl/3UFudVhckESoEC1
	 E77OAtD9nTRUm0PQ=
X-KPN-MID: 33|mTVYqzwd9FyI1VQyr2IEpzz8ZmnXRCPJ5elW4GUq7aO0IHMeg5fjphoXvy+LrHi
 59Q5GkYbyT5W5MVbfS3jxEw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ypOnaXujBH0Ij6SBgFY2wkUXwikGvhltRtVJxMrXjWR+WLeWkxe0qO/cPDYeWTs
 IEi0wh+vjR0JiI9iMEzkpSw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 360dcf59-1b71-11f0-9da2-00505699b758;
	Thu, 17 Apr 2025 11:49:10 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: David Anes <david.anes@suse.com>
Subject: [PATCH 07/10] renice: (man) reword several things, to be clearer, and improve some markup
Date: Thu, 17 Apr 2025 11:48:21 +0200
Message-ID: <20250417094825.20870-7-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250417094825.20870-1-bensberg@telfort.nl>
References: <20250417094825.20870-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, remove a reference to ulimit(1p) that doesn't make sense.

CC: David Anes <david.anes@suse.com>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/renice.1.adoc | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/sys-utils/renice.1.adoc b/sys-utils/renice.1.adoc
index e50e1e918..5f2e2a98d 100644
--- a/sys-utils/renice.1.adoc
+++ b/sys-utils/renice.1.adoc
@@ -46,24 +46,30 @@ renice - alter priority of running processes
 
 == SYNOPSIS
 
-*renice* [*--priority|--relative*] _priority_ [*-g*|*-p*|*-u*] _identifier_...
+*renice* [*-n*|*--priority*|*--relative*] _priority_ [*-g*|*-p*|*-u*] _identifier_...
 
 == DESCRIPTION
 
 *renice* alters the scheduling priority of one or more running processes. The first argument is the _priority_ value to be used. The other arguments are interpreted as process IDs (by default), process group IDs, user IDs, or user names. *renice*'ing a process group causes all processes in the process group to have their scheduling priority altered. *renice*'ing a user causes all processes owned by the user to have their scheduling priority altered.
 
-If no *-n*, *--priority* or *--relative* option is used, then the priority is set as *absolute*.
+By default, _priority_ is understood as an absolute value. But when option *--relative* is given,
+or when option *-n* is given and the environment variable POSIXLY_CORRECT is set, then _priority_
+is understood as a relative value.
 
 == OPTIONS
 
-*-n* _priority_::
-Specify the *absolute* or *relative* (depending on environment variable POSIXLY_CORRECT) scheduling _priority_ to be used for the process, process group, or user. Use of the option *-n* is optional, but when used, it must be the first argument. See *NOTES* for more information.
+*-n* _priority_|__delta__::
+Specify the absolute scheduling priority (when POSIXLY_CORRECT is not set) or a relative
+priority (when POSIXLY_CORRECT *is* set).  See *NOTES* below for more details.
+Using option *-n* is optional, but when used, it must be the first argument.
 
 *--priority* _priority_::
-Specify an *absolute* scheduling _priority_. _Priority_ is set to the given value. This is the default, when no option is specified.
+Specify the absolute scheduling _priority_ to be used.
+This is the default, when no option is specified.
 
-*--relative* _priority_::
-Specify a *relative* scheduling _priority_. Same as the standard POSIX *-n* option. _Priority_ gets _incremented/decremented_ by the given value.
+*--relative* _delta_::
+Specify a relative priority. The actual scheduling priority gets incremented/decremented
+by the given _delta_. (This is the same as the *-n* option when POSIXLY_CORRECT is set.)
 
 *-g*, *--pgrp*::
 Interpret the succeeding arguments as process group IDs.
@@ -83,21 +89,30 @@ to map user names to user IDs
 
 == NOTES
 
-Users other than the superuser may only alter the priority of processes they own. Furthermore, an unprivileged user can only _increase_ the "nice value" (i.e., choose a lower priority) and such changes are irreversible unless (since Linux 2.6.12) the user has a suitable "nice" resource limit (see *ulimit*(1p) and *getrlimit*(2)).
+Users other than the superuser may alter the priority only of processes they own.
+Furthermore, an unprivileged user can only _increase_ the "nice value" (that is:
+lower the urgency), and such changes are irreversible unless (since Linux 2.6.12)
+the user has a suitable "nice" resource limit (see *getrlimit*(2)).
 
 The superuser may alter the priority of any process and set the priority to any value in the range -20 to 19. Useful priorities are: 19 (the affected processes will run only when nothing else in the system wants to), 0 (the "base" scheduling priority), anything negative (to make things go very fast).
 
-For historical reasons in this implementation, the *-n* option did not follow the POSIX specification. Therefore, instead of setting a *relative* priority, it sets an *absolute* priority by default. As this may not be desirable, this behavior can be controlled by setting the environment variable POSIXLY_CORRECT to be fully POSIX compliant. See the *-n* option for details. See *--relative* and *--priority* for options that do not change behavior depending on environment variables.
+For historical reasons, the *-n* option in this implementation does not follow the POSIX
+specification: instead of setting a *relative* priority, it sets an *absolute* priority
+by default. As this may not be desirable, this behavior can be changed by setting the
+environment variable POSIXLY_CORRECT, to be fully POSIX compliant. See *--relative* and
+*--priority* for options that do not change behavior depending on environment variables.
 
 == HISTORY
 
 The *renice* command appeared in 4.0BSD.
 
-== EXAMPLES
+== EXAMPLE
 
-The following command would change the priority of the processes with PIDs 987 and 32, plus all processes owned by the users daemon and root:
+The following command changes the priority of the processes with PIDs 987 and 32, plus all processes owned by the users daemon and root:
 
+____
 *renice +1 987 -u daemon root -p 32*
+____
 
 == SEE ALSO
 
-- 
2.48.1

