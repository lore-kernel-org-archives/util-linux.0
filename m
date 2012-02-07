Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcahe.dreamhost.com ([208.97.132.74]:41514 "EHLO
	homiemail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755661Ab2BGWlz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Feb 2012 17:41:55 -0500
Subject: [RFC PATH 0/4] new lslocks command
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Feb 2012 23:41:50 +0100
Message-ID: <1328654510.3500.9.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

This is a first iteration for the lslocks command to replace the old
lslks. It's a very simplified version as its a very simple command and
Unix legacy stuff has been removed. One thing I have not decided upon is
dealing with processes on a network host (-i, -n).

Like always, please take a look, let me know any bugs/suggestions and
see if it can go in .22.

Thanks,
Davidlohr 

