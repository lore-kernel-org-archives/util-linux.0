Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36165 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbbIRXZa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Sep 2015 19:25:30 -0400
Received: by wicgb1 with SMTP id gb1so50209826wic.1
        for <util-linux@vger.kernel.org>; Fri, 18 Sep 2015 16:25:29 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 18 Sep 2015 16:25:29 -0700
Message-ID: <CAGQyBevyqMbq6KuRi5=E_QnXmjE4BK7P=sK4awostLf5uNiYuA@mail.gmail.com>
Subject: Custom structured data from logger utility
From: Priya Ahuja <priahuja321@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I am using version 2.20.1 logger utility to send logs to rsyslogd from
bash scripts. I want to send logs in RFC5424 format with custom
structured data fields, example: [sdid@enterprise-number level=INFO
id=1234]. I understand 2.20.1 does not support 5424 format but I
looked at the logger.c code in the latest version and seems structured
data fields are set to [timeQuality tzKnown=\"1\" isSynced=\"1\"
syncAccuracy=\"%ld\"]. Is there a way/plan to format custom structured
data?

Thanks,
Priya Ahuja
