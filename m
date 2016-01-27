Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34788 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965935AbcA0TpQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Jan 2016 14:45:16 -0500
Received: by mail-lb0-f173.google.com with SMTP id cl12so11501220lbc.1
        for <util-linux@vger.kernel.org>; Wed, 27 Jan 2016 11:45:15 -0800 (PST)
Received: from ksakep (impulse-kiev.in.ua. [178.214.207.118])
        by smtp.gmail.com with ESMTPSA id go6sm971432lbc.25.2016.01.27.11.45.12
        for <util-linux@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jan 2016 11:45:13 -0800 (PST)
Date: Wed, 27 Jan 2016 21:44:04 +0200
From: Victor Ananjevsky <ananasik@gmail.com>
To: util-linux@vger.kernel.org
Subject: agetty improvement
Message-Id: <20160127214404.14b17964b7509e4839dbf26e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


hi list

is that possible to add a handle of esc sequences (\eXXX) to agetty in an upcomeng releases?
there is a simple patch to do this


--- util-linux-2.24/term-utils/agetty.c.orig	2013-10-10 13:44:17.000000000 +0300
+++ util-linux-2.24/term-utils/agetty.c	2013-11-12 08:12:26.457936826 +0200
@@ -2104,6 +2104,9 @@
 		}
 		break;
 	}
+	case 'e':
+		printf("\033");
+		break;
 	case 'u':
 	case 'U':
 	{


-- 
Victor Ananjevsky <ananasik@gmail.com>
