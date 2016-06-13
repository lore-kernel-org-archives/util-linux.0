Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33283 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423178AbcFMXSi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 13 Jun 2016 19:18:38 -0400
Received: by mail-oi0-f50.google.com with SMTP id u201so104328205oie.0
        for <util-linux@vger.kernel.org>; Mon, 13 Jun 2016 16:18:37 -0700 (PDT)
Received: from [192.168.0.76] (cpe-70-123-244-133.satx.res.rr.com. [70.123.244.133])
        by smtp.gmail.com with ESMTPSA id r188sm12705211oia.0.2016.06.13.16.18.36
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jun 2016 16:18:36 -0700 (PDT)
To: util-linux@vger.kernel.org
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Subject: fstab format
Message-ID: <575F3F4C.9020103@gmail.com>
Date: Mon, 13 Jun 2016 18:18:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Does the fstab file support line continuation with a backslash-newline?

There is no indication in the fstab man page one way or another.  In the 
case of some entries that use long device IDs like PARTUUID or several 
options, it would be nice to be able to control the format for easier reading.

   -- Bruce
