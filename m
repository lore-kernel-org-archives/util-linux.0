Return-Path: util-linux-owner@vger.kernel.org
Received: from e38.co.us.ibm.com ([32.97.110.159]:44959 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab1IUWTz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 21 Sep 2011 18:19:55 -0400
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p8LMBlCr014773
	for <util-linux@vger.kernel.org>; Wed, 21 Sep 2011 16:11:47 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p8LMJp5v094570
	for <util-linux@vger.kernel.org>; Wed, 21 Sep 2011 16:19:51 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p8LMJoO4017485
	for <util-linux@vger.kernel.org>; Wed, 21 Sep 2011 16:19:51 -0600
Date: Wed, 21 Sep 2011 15:19:46 -0700
From: Tim Pepper <lnxninja@linux.vnet.ibm.com>
To: Tim Pepper <tpepper@gmail.com>
Cc: "Ted Ts'o" <tytso@mit.edu>, util-linux@vger.kernel.org
Subject: Re: libuuid clock.txt fd leaks
Message-ID: <20110921221945.GD28823@tpepper-t61p.dolavim.us>
References: <CAHuv5K=UXH=vMZoCgYYvucACru5D8dLa91ufVeY2GJFFSv1ckw@mail.gmail.com>
 <20110921202620.GD4056@thunk.org>
 <CAHuv5Kn4eOjsm9JORpjWJjD15vUEmrOx5K_xzU+wie8f4Cx8AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHuv5Kn4eOjsm9JORpjWJjD15vUEmrOx5K_xzU+wie8f4Cx8AA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed 21 Sep at 15:02:48 -0700 tpepper@gmail.com said:
> 
> I wonder who would whinge on performance if the open/close simply
> happened everytime?  Ie: remove initial state_fd=-2 and its associated
> special casing.

Something sort of like this for get_clock(), completely untested...

-- 
Tim Pepper  <lnxninja@linux.vnet.ibm.com>
IBM Linux Technology Center


--- gen_uuid.c.orig	2011-09-16 14:14:58.902434595 -0700
+++ gen_uuid.c	2011-09-21 15:06:35.271419101 -0700
@@ -316,57 +316,48 @@ static int get_node_id(unsigned char *no
 static int get_clock(uint32_t *clock_high, uint32_t *clock_low,
 		     uint16_t *ret_clock_seq, int *num)
 {
-	THREAD_LOCAL int		adjustment = 0;
-	THREAD_LOCAL struct timeval	last = {0, 0};
-	THREAD_LOCAL int		state_fd = -2;
-	THREAD_LOCAL FILE		*state_f;
-	THREAD_LOCAL uint16_t		clock_seq;
+	int				adjustment = 0;
+	struct timeval			last = {0, 0};
+	int				fd;
+	FILE				*f;
+	uint16_t			clock_seq;
 	struct timeval			tv;
 	uint64_t			clock_reg;
 	mode_t				save_umask;
 	int				len;
 	int				ret = 0;
-
-	if (state_fd == -2) {
-		save_umask = umask(0);
-		state_fd = open("/var/lib/libuuid/clock.txt",
-				O_RDWR|O_CREAT, 0660);
-		(void) umask(save_umask);
-		if (state_fd != -1) {
-			state_f = fdopen(state_fd, "r+");
-			if (!state_f) {
-				close(state_fd);
-				state_fd = -1;
-				ret = -1;
-			}
+	unsigned int			cl;
+	unsigned long			tv1, tv2;
+	int				a;
+
+	save_umask = umask(0);
+	fd = open("/var/lib/libuuid/clock.txt",
+			O_RDWR|O_CREAT, 0660);
+	(void) umask(save_umask);
+	if (fd != -1) {
+		f = fdopen(fd, "r+");
+		if (!f) {
+			close(fd);
+			return -1;
 		}
-		else
-			ret = -1;
 	}
-	if (state_fd >= 0) {
-		rewind(state_f);
-		while (flock(state_fd, LOCK_EX) < 0) {
-			if ((errno == EAGAIN) || (errno == EINTR))
-				continue;
-			fclose(state_f);
-			close(state_fd);
-			state_fd = -1;
-			ret = -1;
-			break;
-		}
+	else
+		return -1;
+
+	while (flock(fd, LOCK_EX) < 0) {
+		if ((errno == EAGAIN) || (errno == EINTR))
+			continue;
+		fclose(f);
+		close(fd);
+		return -1;
 	}
-	if (state_fd >= 0) {
-		unsigned int cl;
-		unsigned long tv1, tv2;
-		int a;
-
-		if (fscanf(state_f, "clock: %04x tv: %lu %lu adj: %d\n",
-			   &cl, &tv1, &tv2, &a) == 4) {
-			clock_seq = cl & 0x3FFF;
-			last.tv_sec = tv1;
-			last.tv_usec = tv2;
-			adjustment = a;
-		}
+
+	if (fscanf(f, "clock: %04x tv: %lu %lu adj: %d\n",
+		   &cl, &tv1, &tv2, &a) == 4) {
+		clock_seq = cl & 0x3FFF;
+		last.tv_sec = tv1;
+		last.tv_usec = tv2;
+		adjustment = a;
 	}
 
 	if ((last.tv_sec == 0) && (last.tv_usec == 0)) {
@@ -406,19 +397,18 @@ try_again:
 		last.tv_usec = last.tv_usec % 1000000;
 	}
 
-	if (state_fd >= 0) {
-		rewind(state_f);
-		len = fprintf(state_f,
-			      "clock: %04x tv: %016lu %08lu adj: %08d\n",
-			      clock_seq, last.tv_sec, last.tv_usec, adjustment);
-		fflush(state_f);
-		if (ftruncate(state_fd, len) < 0) {
-			fprintf(state_f, "                   \n");
-			fflush(state_f);
-		}
-		rewind(state_f);
-		flock(state_fd, LOCK_UN);
-	}
+	rewind(f);
+	len = fprintf(f,
+		      "clock: %04x tv: %016lu %08lu adj: %08d\n",
+		      clock_seq, last.tv_sec, last.tv_usec, adjustment);
+	fflush(f);
+	if (ftruncate(fd, len) < 0) {
+		fprintf(f, "                   \n");
+		fflush(f);
+	}
+	fclose(f);
+	flock(fd, LOCK_UN);
+	close(fd);
 
 	*clock_high = clock_reg >> 32;
 	*clock_low = clock_reg;
