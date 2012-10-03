Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f46.google.com ([209.85.215.46]:42944 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab2JCC7C (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Oct 2012 22:59:02 -0400
Received: by lagh6 with SMTP id h6so2736359lag.19
        for <util-linux@vger.kernel.org>; Tue, 02 Oct 2012 19:59:00 -0700 (PDT)
MIME-Version: 1.0
From: Cody Maloney <cmaloney@theoreticalchaos.com>
Date: Tue, 2 Oct 2012 19:58:39 -0700
Message-ID: <CA+K3q6r_QfCWmCBMEiytKCQG8j-4P92sWxO-ZNz_ALWpr=2knA@mail.gmail.com>
Subject: Adding support to chsh for non-local shell modification
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I would like to implement support for non-local shell changing in chsh
at the very least, and possibly support for non-local user attributes
in general for the other attribute modification tools in login-utils.
For my purposes I need LDAP support, but it would probably be better
to make it able to use an arbitrary storage backend.  Ideally an API
would already exist for this, but while one for setting authentication
tokens has evolved (pam_chauthtok) and one for reading user attributes
(Name Service Switch NSS), but none for setting them as far as I can
tell. As such, I think the best route would be just to make a new API
for this.

I thinks this could be done by adding a new configuration file and
module api. The configuration file would contain information on what
user ids to map to which name attribute changing module (and allow
users to specify only some attributes to go to specific modules). The
module api would consist of a single entry point which would take a
string indicating what attribute to change ("shell", etc.), and the
user id. The function could return any of a set of standard error
codes (permission denied, success, user unknown, etc). chsh would move
all passwd file logic outside of itself and into one of these modules,
and use dlopen/dlsym to load the desired function out of the desired
module.

Should I implement this route and send patches for review, or would
there be some other preferred route to getting the feature into
login-utils?

Thanks,
Cody
