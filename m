Received: from omta003.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4A914F9D6
	for <util-linux@vger.kernel.org>; Sun, 26 Jan 2025 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737913229; cv=none; b=fKhyQH7thZoxHlkM1P+Fv2sbq4YpsKmjUoFKscb502lO2ytpsnw13x2rsasp/4w9/0hlLkRqs1dypUCdhOGm9MV5LKsnLG6QkilDWPEoXodQ21xA4jEOwCPDzP7T+6ikT4NIWZEKCopcJ1Nl6W86ZtvR++mvQu9m94g1oKY4qjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737913229; c=relaxed/simple;
	bh=Cw4z8sL1g0bZTUH/FTORK6L5Yv3mHRyo5kVN4F5ncQc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=o8BtprH2BZCDR7lWbsfTNyT//AdfCFwtlFe+m4wIaOZvWb6o+aZtbiiUk93+tI0VD7JQ16L9RMvqW3THQTXjbl1pBaMkGN4pd2m/SwWfiTQ+sOTobjJ/4LGa610PtKE3Vi7F0KsZPoxpqQwDXKb6VtvtqTpbCrphFhSnNUe18bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net; spf=pass smtp.mailfrom=tuyoix.net; arc=none smtp.client-ip=3.97.99.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuyoix.net
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
	by cmsmtp with ESMTPS
	id c3RjtSQ9yxv7Pc6cOtDqG6; Sun, 26 Jan 2025 17:40:20 +0000
Received: from fanir.tuyoix.net ([68.150.218.192])
	by cmsmtp with ESMTP
	id c6cNtaqtJJhBPc6cNtlXq6; Sun, 26 Jan 2025 17:40:20 +0000
X-Authority-Analysis: v=2.4 cv=QY3Fvdbv c=1 sm=1 tr=0 ts=67967384
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=M51BFTxLslgA:10 a=skbIlk6SAAAA:8
 a=3I1X_3ewAAAA:8 a=Lq5NcF5sIDnYhj_cvl8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=P5SZwATmzn4K3VfFWgKo:22 a=VG9N9RgkD3hcbI6YpJ1l:22
Received: from tuyoix.net (fanir.tuyoix.net [192.168.144.16])
	(authenticated bits=0)
	by fanir.tuyoix.net (8.18.1/8.18.1) with ESMTPSA id 50QHeJwt024555
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <util-linux@vger.kernel.org>; Sun, 26 Jan 2025 10:40:19 -0700
Date: Sun, 26 Jan 2025 10:40:19 -0700 (MST)
From: =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] Add setsid option to save child process id
Message-ID: <be555f23-ae5e-f7d1-9b7c-28f4191664e7@tuyoix.net>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-CMAE-Envelope: MS4xfM12LeLW7XV8TkRx8yaMgmnnhw3czLaU9kpdzCyogmBXBENEv5MXu+TG+w3HdCRQJFgi2EQTPyMzxnx5wiBs1ufhEnW9oFyMBmiOo8qKARUSgNftD7cZ
 7tAy1oIIKioii6MSLLNPK8/SVRCx/swk3V/dATI+lxBOxHm6o5niZqpqml1ae3Dl1NB4BKxPKyXvuiV7fp/nyUkAtjLdLWJYRX8=

Add an option to save the child's pid into a file.

Marc.

diff -NRapruz -X /etc/diff.excludes util-linux-2.40.4/sys-utils/setsid.1.adoc devel-2.40.4/sys-utils/setsid.1.adoc
--- util-linux-2.40.4/sys-utils/setsid.1.adoc
+++ devel-2.40.4/sys-utils/setsid.1.adoc
@@ -31,6 +31,9 @@ Always create a new process.
 *-w*, *--wait*::
 Wait for the execution of the program to end, and return the exit status of this program as the exit status of *setsid*.

+*-p*, *--pidfile* _file_::
+If forked, write the process id of the program to _file_.
+
 *-V*, *--version*::
 Display version information and exit.

diff -NRapruz -X /etc/diff.excludes util-linux-2.40.4/sys-utils/setsid.c devel-2.40.4/sys-utils/setsid.c
--- util-linux-2.40.4/sys-utils/setsid.c
+++ devel-2.40.4/sys-utils/setsid.c
@@ -14,6 +14,9 @@
  *
  * 2008-08-20 Daniel Kahn Gillmor <dkg@fifthhorseman.net>
  * - if forked, wait on child process and emit its return code.
+ *
+ * 2025-01-25 Marc Aurèle La France <tsi@tuyoix.net>
+ * - If forked, save the child's process id in a file.
  */
 #include <getopt.h>
 #include <stdio.h>
@@ -39,11 +42,12 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("Run a program in a new session.\n"), out);

 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -c, --ctty     set the controlling terminal to the current one\n"), out);
-	fputs(_(" -f, --fork     always fork\n"), out);
-	fputs(_(" -w, --wait     wait program to exit, and use the same return\n"), out);
+	fputs(_(" -c, --ctty               set the controlling terminal to the current one\n"), out);
+	fputs(_(" -f, --fork               always fork\n"), out);
+	fputs(_(" -w, --wait               wait program to exit, and use the same return\n"), out);
+	fputs(_(" -p, --pidfile <file>     write child pid to <file>\n"), out);

-	fprintf(out, USAGE_HELP_OPTIONS(16));
+	fprintf(out, USAGE_HELP_OPTIONS(26));

 	fprintf(out, USAGE_MAN_TAIL("setsid(1)"));
 	exit(EXIT_SUCCESS);
@@ -55,14 +59,17 @@ int main(int argc, char **argv)
 	int ctty = 0;
 	pid_t pid;
 	int status = 0;
+	const char *pidpath = NULL;
+	FILE *pidfile;

 	static const struct option longopts[] = {
-		{"ctty", no_argument, NULL, 'c'},
-		{"fork", no_argument, NULL, 'f'},
-		{"wait", no_argument, NULL, 'w'},
-		{"version", no_argument, NULL, 'V'},
-		{"help", no_argument, NULL, 'h'},
-		{NULL, 0, NULL, 0}
+		{"ctty",    no_argument,       NULL, 'c'},
+		{"fork",    no_argument,       NULL, 'f'},
+		{"wait",    no_argument,       NULL, 'w'},
+		{"pidfile", required_argument, NULL, 'p'},
+		{"version", no_argument,       NULL, 'V'},
+		{"help",    no_argument,       NULL, 'h'},
+		{NULL,      0,                 NULL, 0}
 	};

 	setlocale(LC_ALL, "");
@@ -70,7 +77,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	close_stdout_atexit();

-	while ((ch = getopt_long(argc, argv, "+Vhcfw", longopts, NULL)) != -1)
+	while ((ch = getopt_long(argc, argv, "+Vhcfp:w", longopts, NULL)) != -1)
 		switch (ch) {
 		case 'c':
 			ctty=1;
@@ -81,6 +88,9 @@ int main(int argc, char **argv)
 		case 'w':
 			status = 1;
 			break;
+		case 'p':
+			pidpath = optarg;
+			break;

 		case 'h':
 			usage();
@@ -105,6 +115,16 @@ int main(int argc, char **argv)
 			break;
 		default:
 			/* parent */
+			if (pidpath) {
+				pidfile = fopen(pidpath, "w");
+				if (pidfile == NULL)
+					warn(_("cannot open pidfile %s"),
+						pidpath);
+				else {
+					fprintf(pidfile, "%d\n", pid);
+					fclose(pidfile);
+				}
+			}
 			if (!status)
 				return EXIT_SUCCESS;
 			if (wait(&status) != pid)
