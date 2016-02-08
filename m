Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:57667 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453AbcBHKqH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Feb 2016 05:46:07 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0McVns-1akGBJ1SO8-00Hfhs for
 <util-linux@vger.kernel.org>; Mon, 08 Feb 2016 11:46:05 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: some quesion about test_uuidd
Date: Mon, 8 Feb 2016 11:46:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201602081146.04421.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

since 963f128c we are building test_uuidd in tests/helpers.

Where do we use test_uuidd at the moment?

Because it breakes "configure --disable-libuuid we should guard the 
test_uuidd build either bei BUILD_LIBUUID or by BUILD_UUIDD. Maybe it 
should also be moved to misc-utils/ (where uuidd lives) or libuuid/src/ 
(where test_uuid lives). Opinions?

cu,
Rudi
