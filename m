Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.pxnet.com ([89.1.7.7]:37261 "EHLO mail.pxnet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803AbbGINbj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 9 Jul 2015 09:31:39 -0400
Message-Id: <7accabcec95a5fb1a5ca91b34df23443fb7b3518.1436438005.git.tilman@imap.cc>
In-Reply-To: <cover.1436438005.git.tilman@imap.cc>
References: <cover.1436438005.git.tilman@imap.cc>
From: Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH 3/3] ldattach: always set line speed and format for N_GIGASET_M101
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Tilman Schmidt <tilman@imap.cc>,
        Paul Bolle <pebolle@tiscali.nl>, Sami Kerola <kerolasa@iki.fi>
Date: Thu,  9 Jul 2015 15:22:32 +0200 (CEST)
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The Gigaset M101 exhibits particularly awkward and confusing behaviour
when the serial line speed isn't set to what the device expects:
Configuration mode detects the used speed and works anyway, but data
mode silently fails. Troubleshooting this is enormously time-consuming.

Spare the users this trouble by setting the line speed and format to
these devices' factory default values as long as the command line
doesn't say otherwise.

Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---
 sys-utils/ldattach.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sys-utils/ldattach.c b/sys-utils/ldattach.c
index bd4fadd..99db32e 100644
--- a/sys-utils/ldattach.c
+++ b/sys-utils/ldattach.c
@@ -366,6 +366,15 @@ int main(int argc, char **argv)
 	if (ldisc < 0)
 		ldisc = strtos32_or_err(argv[optind], _("invalid line discipline argument"));
 
+	/* ldisc specific option settings */
+	if (ldisc == N_GIGASET_M101) {
+		/* device specific defaults for line speed and data format */
+		if (speed == 0) speed = 115200;
+		if (bits == '-') bits = '8';
+		if (parity == '-') parity = 'n';
+		if (stop == '-') stop = '1';
+	}
+
 	/* open device */
 	dev = argv[optind + 1];
 	if ((tty_fd = open(dev, O_RDWR | O_NOCTTY)) < 0)
@@ -448,12 +457,13 @@ int main(int argc, char **argv)
 		}
 	}
 
-	/* Attach the line discpline. */
+	/* Attach the line discipline. */
 	if (ioctl(tty_fd, TIOCSETD, &ldisc) < 0)
 		err(EXIT_FAILURE, _("cannot set line discipline"));
 
 	dbg("line discipline set to %d", ldisc);
 
+	/* ldisc specific post-attach actions */
 	if (ldisc == N_GSM0710)
 		gsm0710_set_conf(tty_fd);
 
-- 
1.9.2.459.g68773ac

