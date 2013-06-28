Return-Path: util-linux-owner@vger.kernel.org
Received: from nm43-vm10.bullet.mail.bf1.yahoo.com ([216.109.114.171]:33246
	"EHLO nm43-vm10.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755189Ab3F1J6V convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 28 Jun 2013 05:58:21 -0400
References: <1372412934.77779.YahooMailNeo@web162205.mail.bf1.yahoo.com>
Message-ID: <1372413058.87399.YahooMailNeo@web162204.mail.bf1.yahoo.com>
Date: Fri, 28 Jun 2013 02:50:58 -0700 (PDT)
From: Marek Mrva <mrvamarek@yahoo.com>
Reply-To: Marek Mrva <mrvamarek@yahoo.com>
Subject: [bug] Cannot mount from directories containing = (equals)
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
In-Reply-To: <1372412934.77779.YahooMailNeo@web162205.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello, hopefully this is the correct mailing list...


I have noticed an odd behavior [subject] when trying to mount some ext2 disk file image

This problem probably occurs because the = character forces the mount command to interpret the path as an UUID rather than a file

Some info:

# mount -V
mount from util-linux 2.22.2 (libmount 2.22.0: debug)



I wonder, is this more of a bug or a feature? Any help would be greatly appreciated :-)


Best regards,
  Marek Mrva

