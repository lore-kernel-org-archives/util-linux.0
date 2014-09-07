Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f182.google.com ([209.85.212.182]:51031 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbaIGMno (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 08:43:44 -0400
Received: by mail-wi0-f182.google.com with SMTP id z2so1381048wiv.3
        for <util-linux@vger.kernel.org>; Sun, 07 Sep 2014 05:43:43 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/17] eject: make open_device() and select_speed() to use struct eject_control
Date: Sun,  7 Sep 2014 13:43:01 +0100
Message-Id: <1410093785-17537-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/eject.c | 54 +++++++++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 767ede7..12a9bbb 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -488,10 +488,10 @@ static void toggle_tray(int fd)
  * Thanks to Roland Krivanek (krivanek@fmph.uniba.sk)
  * http://dmpc.dbp.fmph.uniba.sk/~krivanek/cdrom_speed/
  */
-static void select_speed(int fd, int speed)
+static void select_speed(const struct eject_control *ctl)
 {
 #ifdef CDROM_SELECT_SPEED
-	if (ioctl(fd, CDROM_SELECT_SPEED, speed) != 0)
+	if (ioctl(ctl->fd, CDROM_SELECT_SPEED, ctl->x_arg) != 0)
 		err(EXIT_FAILURE, _("CD-ROM select speed command failed"));
 #else
 	warnx(_("CD-ROM select speed command not supported by this kernel"));
@@ -560,22 +560,22 @@ static int read_speed(const char *devname)
 /*
  * List Speed of CD-ROM drive.
  */
-static void list_speeds(const struct eject_control *ctl)
+static void list_speeds(struct eject_control *ctl)
 {
 #ifdef CDROM_SELECT_SPEED
-	int max_speed, curr_speed = 0, prev_speed;
+	int max_speed, curr_speed = 0;
 
-	select_speed(ctl->fd, 0);
+	select_speed(ctl);
 	max_speed = read_speed(ctl->device);
 
 	while (curr_speed < max_speed) {
-		prev_speed = curr_speed;
-		select_speed(ctl->fd, prev_speed + 1);
+		ctl->x_arg = curr_speed + 1;
+		select_speed(ctl);
 		curr_speed = read_speed(ctl->device);
-		if (curr_speed > prev_speed)
+		if (ctl->x_arg < curr_speed)
 			printf("%d ", curr_speed);
 		else
-			curr_speed = prev_speed + 1;
+			curr_speed = ctl->x_arg + 1;
 	}
 
 	printf("\n");
@@ -704,15 +704,13 @@ static void umount_one(const struct eject_control *ctl, const char *name)
 }
 
 /* Open a device file. */
-static int open_device(const char *name)
+static void open_device(struct eject_control *ctl)
 {
-	int fd = open(name, O_RDWR|O_NONBLOCK);
-
-	if (fd < 0)
-		fd = open(name, O_RDONLY|O_NONBLOCK);
-	if (fd == -1)
-		err(EXIT_FAILURE, _("cannot open %s"), name);
-	return fd;
+	ctl->fd = open(ctl->device, O_RDWR | O_NONBLOCK);
+	if (ctl->fd < 0)
+		ctl->fd = open(ctl->device, O_RDONLY | O_NONBLOCK);
+	if (ctl->fd == -1)
+		err(EXIT_FAILURE, _("cannot open %s"), ctl->device);
 }
 
 /*
@@ -932,10 +930,8 @@ done:
 
 
 /* handle -x option */
-static void set_device_speed(const struct eject_control *ctl)
+static void set_device_speed(struct eject_control *ctl)
 {
-	int fd;
-
 	if (!ctl->x_option)
 		return;
 
@@ -944,8 +940,8 @@ static void set_device_speed(const struct eject_control *ctl)
 	else
 		verbose(ctl, _("setting CD-ROM speed to %ldX"), ctl->x_arg);
 
-	fd = open_device(ctl->device);
-	select_speed(fd, ctl->x_arg);
+	open_device(ctl);
+	select_speed(ctl);
 	exit(EXIT_SUCCESS);
 }
 
@@ -1031,7 +1027,7 @@ int main(int argc, char **argv)
 
 	/* handle -i option */
 	if (ctl.i_option) {
-		ctl.fd = open_device(ctl.device);
+		open_device(&ctl);
 		manual_eject(&ctl);
 		return EXIT_SUCCESS;
 	}
@@ -1042,7 +1038,7 @@ int main(int argc, char **argv)
 			verbose(&ctl, _("%s: enabling auto-eject mode"), ctl.device);
 		else
 			verbose(&ctl, _("%s: disabling auto-eject mode"), ctl.device);
-		ctl.fd = open_device(ctl.device);
+		open_device(&ctl);
 		auto_eject(&ctl);
 		return EXIT_SUCCESS;
 	}
@@ -1050,7 +1046,7 @@ int main(int argc, char **argv)
 	/* handle -t option */
 	if (ctl.t_option) {
 		verbose(&ctl, _("%s: closing tray"), ctl.device);
-		ctl.fd = open_device(ctl.device);
+		open_device(&ctl);
 		close_tray(ctl.fd);
 		set_device_speed(&ctl);
 		return EXIT_SUCCESS;
@@ -1059,7 +1055,7 @@ int main(int argc, char **argv)
 	/* handle -T option */
 	if (ctl.T_option) {
 		verbose(&ctl, _("%s: toggling tray"), ctl.device);
-		ctl.fd = open_device(ctl.device);
+		open_device(&ctl);
 		toggle_tray(ctl.fd);
 		set_device_speed(&ctl);
 		return EXIT_SUCCESS;
@@ -1068,7 +1064,7 @@ int main(int argc, char **argv)
 	/* handle -X option */
 	if (ctl.X_option) {
 		verbose(&ctl, _("%s: listing CD-ROM speed"), ctl.device);
-		ctl.fd = open_device(ctl.device);
+		open_device(&ctl);
 		list_speeds(&ctl);
 		return EXIT_SUCCESS;
 	}
@@ -1100,7 +1096,7 @@ int main(int argc, char **argv)
 	/* handle -c option */
 	if (ctl.c_option) {
 		verbose(&ctl, _("%s: selecting CD-ROM disc #%ld"), ctl.device, ctl.c_arg);
-		ctl.fd = open_device(ctl.device);
+		open_device(&ctl);
 		changer_select(&ctl);
 		set_device_speed(&ctl);
 		return EXIT_SUCCESS;
@@ -1111,7 +1107,7 @@ int main(int argc, char **argv)
 		ctl.r_option = ctl.s_option = ctl.f_option = ctl.q_option = 1;
 
 	/* open device */
-	ctl.fd = open_device(ctl.device);
+	open_device(&ctl);
 
 	/* try various methods of ejecting until it works */
 	if (ctl.r_option) {
-- 
2.1.0

