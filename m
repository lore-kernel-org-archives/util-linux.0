Return-Path: linux-kernel-owner@vger.kernel.org
Date: Sun, 13 Mar 2016 21:32:24 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Karel Zak <kzak@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.28-rc1
Message-ID: <20160313203224.GR4295@var.home>
References: <20160311114701.oqbcsy2aiavj4ejz@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oLBj+sq0vYjzfsbl"
In-Reply-To: <20160311114701.oqbcsy2aiavj4ejz@ws.net.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

2.28-rc1 doesn't build on the Hurd system, see attached proposed patch.

sigset_t is not a structure on Hurd. Applications are not supposed to
assume what it is, and the first thing that sulogin.c does on it is
sigemptyset already anyway.

Samuel

--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 643712f..43ca0d4 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -859,7 +863,7 @@ int main(int argc, char **argv)
 	struct passwd *pwd;
 	struct timespec sigwait = { .tv_sec = 0, .tv_nsec = 50000000 };
 	siginfo_t status = {};
-	sigset_t set = {};
+	sigset_t set;
 	int c, reconnect = 0;
 	int opt_e = 0;
 	int wait = 0;

--oLBj+sq0vYjzfsbl--
