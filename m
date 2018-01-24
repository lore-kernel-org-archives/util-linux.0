Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932187AbeAXNiN (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 24 Jan 2018 08:38:13 -0500
Date: Wed, 24 Jan 2018 14:38:08 +0100
From: Karel Zak <kzak@redhat.com>
To: Libor Bukata <lbukata@gmail.com>
Cc: Timofey Titovets <nefelim4ag@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: Patch to add support for lz4hc and deflate optimization
 algorithms in zramctl.
Message-ID: <20180124133808.au5ev6mxkjmw75ba@ws.net.home>
References: <90fb3b4a-38b8-17fc-f1b6-03e8c23eb808@gmail.com>
 <CAGqmi75B7yzQp-EWBnbjXgSpbNZAsXah1WtQqPUOE6_NjZRwhA@mail.gmail.com>
 <CAGqmi75=cWbRBxU-DkxyXffQSjy8f5jxA_Hx6oVqUrLU_sU9GA@mail.gmail.com>
 <47fb6e30-50a8-29a2-810e-5c872f76813d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47fb6e30-50a8-29a2-810e-5c872f76813d@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 23, 2018 at 06:57:06PM +0100, Libor Bukata wrote:
> Thank you for your comments. I added the support for 842 compression
> algorithm.

@@ -424,13 +424,18 @@ static void fill_table_row(struct libscols_table *tb, struct zram *z)
 			char *alg = sysfs_strdup(sysfs, "comp_algorithm");
 			if (!alg)
 				break;
-			if (strstr(alg, "[lzo]") == NULL) {
-				if (strstr(alg, "[lz4]") == NULL)
-					;
-				else
-					str = xstrdup("lz4");
-			} else
+
+			if (strstr(alg, "[lzo]") != NULL)
 				str = xstrdup("lzo");
+			else if (strstr(alg, "[lz4]") != NULL)
+				str = xstrdup("lz4");
+			else if (strstr(alg, "[lz4hc]") != NULL)
+				str = xstrdup("lz4hc");
+			else if (strstr(alg, "[deflate]") != NULL)
+				str = xstrdup("deflate");
+			else if (strstr(alg, "[842]") != NULL)
+				str = xstrdup("842");
+

The question is if we really need to care about the algorithm string
at all. I think it would be better to accept arbitrary string from
sysfs and just remove "[" and "]" from the string only.

 		switch (c) {
 		case 'a':
-			if (strcmp(optarg,"lzo") && strcmp(optarg,"lz4"))
+			if (strcmp(optarg,"lzo") && strcmp(optarg,"lz4") && strcmp(optarg,"lz4hc")
+					&& strcmp(optarg,"deflate") && strcmp(optarg,"842"))
 				errx(EXIT_FAILURE, _("unsupported algorithm: %s"),

The same situation. I guess we can accept arbitrary string here and
assume that kernel is smart enough to reject requests to use wrong
algorithm name.

    Karel

-- 
2.13.6



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
