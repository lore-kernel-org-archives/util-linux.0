Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDD215530C
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2025 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414359; cv=none; b=J3mWwK7BtooX8zi/lDylSyUUN7+Vu51bK8Nz4MQ4ny2oqUfDJVGVBV54TvJ6cOW/HHywIvOu+LNK5IRw2Z3y5WaPlBn1jU7Lfw9TCrLluTQbfaaOCCXfqk0spf7VTNt8ePBXF8yBppVXJ2SsZxvp0tkT6nR5JMIA433Z5pLxTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414359; c=relaxed/simple;
	bh=0/tREPUI6DvjegB7Sd3I4nw8Jarqmwm8rJlPujcXRjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7eoQljx0Yc+aArXjrNRgLQu+h/2WJO7G5bJAcQ2Te+ryoO3zJl5pTf9oOw4Zr1ZAB5UZ2F665ewvYvxZOOs3HXJ5CI2yR1rfAIBdHMDFBUUB0aFZ9FLA8awujaOpeD0rbpdrxNr+HprrnbkrHdxU7uMZ3Z0cJnD1PB3h34GnVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=PWJ8wRUf; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="PWJ8wRUf"
X-KPN-MessageId: 01178576-0e15-11f0-a82d-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 01178576-0e15-11f0-a82d-005056abad63;
	Mon, 31 Mar 2025 11:46:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=pojRKz2C8pMnOwq/9yLYXdASJKW8jDENG61DBEDCshA=;
	b=PWJ8wRUfKY/9OwAl/YJouOkt33mctF0TKiZ0k8dr8A7srh6kU7Yd7WAfVuwlVgwuBnuett9t7ZKjp
	 /LxF7p8Pq4PrFvo1qVToq+jcUNy8TqyG6dC5TBcPVUyl+znvYLBmHsxXlxN+z73fdACBAVxaTNY1fu
	 VZ0Hqbg3v2+kAtsI=
X-KPN-MID: 33|6ed2eRnoCYwL/SOyqTw1HUv2ccv6mDvGdu+CDbMP6WTkC5v93MGMc3Ds/Fzwb/Y
 6m/B+dTX1qrLu2P74rmsUKZppuW4nLhLu/pCPwkQFSk8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ou5n+jdlpJMJNx5kXSYxJfzpcTFzoMLscQbRbSs8pFbCrEidPGCP1yHxw2XmRlN
 JRgM5n7UBc3QbQawp1Bk4XA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id f1912b11-0e14-11f0-9bef-005056ab7447;
	Mon, 31 Mar 2025 11:45:56 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Phil Auld <pauld@redhat.com>,
	Thijs Raymakers <thijs@raymakers.nl>
Subject: [PATCH 09/10] coresched: reduce excessive whitespace and verbosity in usage text
Date: Mon, 31 Mar 2025 11:44:42 +0200
Message-ID: <20250331094443.9619-9-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331094443.9619-1-bensberg@telfort.nl>
References: <20250331094443.9619-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, use semicolons instead of periods in option descriptions.

And consistently use an uppercased "PID" in feedback messages.

CC: Phil Auld <pauld@redhat.com>
CC: Thijs Raymakers <thijs@raymakers.nl>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 schedutils/coresched.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/schedutils/coresched.c b/schedutils/coresched.c
index 9d8be3e12..7634d988c 100644
--- a/schedutils/coresched.c
+++ b/schedutils/coresched.c
@@ -80,31 +80,24 @@ static void __attribute__((__noreturn__)) usage(void)
 		program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, stdout);
-	fputsln(_("Manage core scheduling cookies for tasks."), stdout);
+	fputsln(_("Manage core-scheduling cookies for tasks."), stdout);
 
 	fputs(USAGE_FUNCTIONS, stdout);
-	fputsln(_(" get                      retrieve the core scheduling cookie of a PID"),
-		stdout);
-	fputsln(_(" new                      assign a new core scheduling cookie to an existing\n"
-		  "                            PID or execute a program with a new cookie"),
-		stdout);
-	fputsln(_(" copy                     copy the core scheduling cookie from an existing PID\n"
-		  "                            to another PID, or execute a program with that\n"
-		  "                            copied cookie"),
-		stdout);
+	fputsln(_(" get      retrieve the core-scheduling cookie of a PID"), stdout);
+	fputsln(_(" new      assign a new cookie to an existing PID,\n"
+		  "            or execute a program with a new cookie"), stdout);
+	fputsln(_(" copy     copy the cookie from an existing PID to another PID,\n"
+		  "            or execute a program with that copied cookie"), stdout);
 
 	fputs(USAGE_OPTIONS, stdout);
 	fprintf(stdout,
-		_(" -s, --source <PID>       which PID to get the cookie from\n"
-		  "                            If omitted, it is the PID of %s itself\n"),
+		_(" -s, --source <PID>       which PID to get the cookie from; if this option\n"
+		  "                            is omitted, the PID of %s itself is used\n"),
 		program_invocation_short_name);
-	fputsln(_(" -d, --dest <PID>         which PID to modify the cookie of\n"),
-		stdout);
-	fputsln(_(" -t, --dest-type <TYPE>   type of the destination PID, or the type of the PID\n"
-		  "                            when a new core scheduling cookie is created.\n"
-		  "                            Can be one of the following: pid, tgid or pgid.\n"
-		  "                            The default is tgid."),
-		stdout);
+	fputsln(_(" -d, --dest <PID>         which PID to modify the cookie of"), stdout);
+	fputsln(_(" -t, --dest-type <TYPE>   type of the new or destination PID; can be one\n"
+		  "                            of: pid, tgid, pgid; default: tgid"), stdout);
+
 	fputs(USAGE_SEPARATOR, stdout);
 	fputsln(_(" -v, --verbose      verbose"), stdout);
 	fprintf(stdout, USAGE_HELP_OPTIONS(20));
@@ -341,7 +334,7 @@ int main(int argc, char **argv)
 	switch (args.cmd) {
 	case SCHED_CORE_CMD_GET:
 		cookie = core_sched_get_cookie(args.src);
-		printf(_("cookie of pid %d is 0x%llx\n"), args.src, cookie);
+		printf(_("cookie of PID %d is 0x%llx\n"), args.src, cookie);
 		break;
 	case SCHED_CORE_CMD_NEW:
 		if (args.exec_argv_offset) {
-- 
2.48.1

