Return-Path: <SRS0=Ur/j=QA=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4214C282C3
	for <util-linux@archiver.kernel.org>; Thu, 24 Jan 2019 15:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8792621872
	for <util-linux@archiver.kernel.org>; Thu, 24 Jan 2019 15:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rydal-org.20150623.gappssmtp.com header.i=@rydal-org.20150623.gappssmtp.com header.b="hyfjQ+tL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfAXPHM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:07:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51741 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfAXPHM (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 24 Jan 2019 10:07:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so3513334wmj.1
        for <util-linux@vger.kernel.org>; Thu, 24 Jan 2019 07:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rydal-org.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=hJ6MCi25UITLDXKf5gXbTQyXxUgkQPWJf7cOxuVpfU8=;
        b=hyfjQ+tLExaWyIf9fzoX1iHQ79qZoKxzuRvNxE6JKbJ2XGWoT3D2E2GrvvjUE5MyEU
         +j/De4H4FSR+koDD82HSSupL24v8yM5z53oFQWu4Z9oC7hRiwHyIgEScFw0kHtT+j9wA
         SxUSn7bArS0+BWHtQcXvJ1U9lV/E9zyIOUlhHVqoKd6FjgymqEFsznzhdpQZyxdDKxgz
         HabYt+U8c9quGb/wATd28jjy1lSDPLjkaMdwoym7NjuCEXjQu2emo7cszWGQkeXsokwG
         YNrV8GKhGnEW692G05ndzTUPACycaNYnKdcoWH4jM72xqGbnqcGSDNi+jw681e42YYCH
         srrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=hJ6MCi25UITLDXKf5gXbTQyXxUgkQPWJf7cOxuVpfU8=;
        b=dwWx4L+NiD4vi0BueaJwye3eQpUyGyWt2maKq6F3Nn3bsrrEpZZqUJdROb5ahfOWeJ
         BaV/+nj8ZTIisjaJOy5YHwcDttgRnM0tuZCOdy0gVfGkQ+r/Pw3LzugZ84uy/qNoyq6G
         y0gsUlpHmK+RApbiqqidqo1rwxaqFWC2DlMQ37ppmRJdXZXw3EaJ1FRzLuxECgmI/ydK
         3ghCa7QcrPIymBdo4a2G/RHFCgPf5R5M3zGMvqYvnhwxqZzB+96SyH+6nTnrUl2LOQVv
         unSAdFgghBWDM1y51dPIYMcI0kX8Pxx6pU1F0FiFuhu8pANu1oLy4OglDHbk+llqWyK0
         2Pyg==
X-Gm-Message-State: AJcUukfOXAWokgIsPc7psNwmqGTBVZVs7bPq6d1CL9fA0HYOre/KdkWK
        LWFrX2u/tXR8FuGmfaw+BIlyvQJx+l0=
X-Google-Smtp-Source: ALg8bN7LSKS7pq6y76VMKkGRR1o5nxV6qyJ+QhzQMAqgrdHRwmRaPBidxeUutI6g6oFUTQReGRjyNA==
X-Received: by 2002:a1c:9855:: with SMTP id a82mr2914385wme.20.1548342429600;
        Thu, 24 Jan 2019 07:07:09 -0800 (PST)
Received: from [129.12.129.161] (stu81A1.kent.ac.uk. [129.12.129.161])
        by smtp.gmail.com with ESMTPSA id n6sm58432097wmk.9.2019.01.24.07.07.08
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 07:07:08 -0800 (PST)
To:     util-linux@vger.kernel.org
From:   Rob Brew <rob@rydal.org>
Subject: Tuxconfig - automated linux kernel module installer.
Message-ID: <e47029b0-8ce8-437d-c8ed-90550a773009@rydal.org>
Date:   Thu, 24 Jan 2019 15:07:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi all.

For my Master's dissertation at Kent University I've built a platform 
and GUI to automate the process of submitting kernel module 
configurations and installing kernel modules from those configurations.

Developers submit kernel module source code including a special file as 
to how these kernel modules are built.
End users have a graphical way of installing said kernel modules, as 
well as upgrading them and uninstalling them, and recovering failed builds.

Think of it as a Ubuntu restricted drivers app enhanced by allowing 
anyone to contribute a git repository for others to install, or the 
windows "install new device" process..

It's a proof of concept, and does need some work in order to be a final 
version.

https://github.com/rydal/dissertation-doc 
<https://github.com/rydal/dissertation-doc>is the dissertation document, 
with readme.md defining what it does.
https://github.com/rydal/tuxconfig-backend 
<https://github.com/rydal/tuxconfig-backend>is the back end written in 
Java and JSP.
https://github.com/rydal/tuxconfig-frontend 
<https://github.com/rydal/tuxconfig-frontend>is the front end written in 
C++.


What i need:
In order to prevent malicious code and Trojan horses the platform will 
need a team to vet each contribution to ensure binaries come from 
trusted sources and Makefiles aren't damaging to the system.

The package and website for those contributing is at 
https://www.linuxconf.feedthepenguin.org/hehe/ 
<https://www.linuxconf.feedthepenguin.org/hehe/>

Features which could be added:
Change the udev rules to make the application run every time a new 
device is inserted
Harsher recovery when adding Linux packages.
Cryptographicaly signing the get and post requests to ensure they are 
from the application.

I'm happy to work on this concept, as well as moderate the git pull 
requests.

Thanks,
  Rob Brew.


