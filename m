Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f177.google.com ([209.85.192.177]:60013 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036Ab3JCJgk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 3 Oct 2013 05:36:40 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so2211047pdj.22
        for <util-linux@vger.kernel.org>; Thu, 03 Oct 2013 02:36:40 -0700 (PDT)
From: Michael Forney <mforney@mforney.org>
To: util-linux@vger.kernel.org
Subject: Various portability fixes
Date: Thu,  3 Oct 2013 02:36:04 -0700
Message-Id: <1380792968-1176-1-git-send-email-mforney@mforney.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

These patches address various portability issues. They are needed to build
util-linux against musl libc.

