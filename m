Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34475 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932174AbcKNQbd (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 14 Nov 2016 11:31:33 -0500
Received: by mail-qk0-f177.google.com with SMTP id q130so101894873qke.1
        for <util-linux@vger.kernel.org>; Mon, 14 Nov 2016 08:31:33 -0800 (PST)
MIME-Version: 1.0
From: Jim Patterson <jimp@wegrok.net>
Date: Mon, 14 Nov 2016 11:31:32 -0500
Message-ID: <CADBFhQdpTibzv8G8gLXS+TW6XFg=WFjNG6+dy7snKLf44ToGQw@mail.gmail.com>
Subject: New option for wall to limit message by group?
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The company that I work for has an old terminal application that is
still in use today.  This app used to run on AIX boxes but has been
moved to modern Linux based systems.  The users on this application
are in groups and under AIX we used the "-g" switch on wall to be able
to send a message to a single group at a time.  The wall on Linux does
not offer this option.  I will either be adding this option to wall or
writing a custom tool to support sending a message based on the user's
groups.

Is there any interest in a pull request supporting such an option in
the standard wall?  And if so, does anyone have any particular
concerns about implementation details?

The AIX man page does not describe the implementation details, but
experimenting with the command on an AIX system shows that the the
message is sent to all users that have the specified group in the
primary or supplementary groups.  My plan for doing this on a Linux
system is to use the username in the utmp entry to lookup the user's
primary and supplementary groups, then skip the utmp entry if the user
does not have the specified group.

Thanks in advance,
Jim P

PS. I'm not subscribed to the group, so please reply to this address also.
