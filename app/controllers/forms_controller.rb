class FormsController < ApplicationController

  def create
    @form = Form.new(form_params)
    if @form.save
      redirect_to result_form_path(@form)
    else
      render :enter
    end
  end

  def destroy
  end

  def enter
    @form = Form.new
  end

  def result
    @form = Form.find_by(id: params[:id])
    if @form.product_type == "ソフトウェア"
      @software = Solution.where(description: "テックイベント参加支援")
    else
      @software = nil
    end
    if @form.series == "シード"
      @seed = Solution.where(description: "長期アクセラレーションプログラム").where.not(classification: "X-Hub").where(title: "内閣府アクセラレーションプログラム Global Preparationコース")
    else
      @seed = nil
    end

    if @form.series == "シリーズB" || "シリーズA"
      @seriesab = Solution.where(title: "内閣府アクセラレーションプログラム Global Preparationコース")
    else
      @seriesab = nil
    end

    if @form.company_type == "法人向け"
      @btob = Solution.where(description: "長期アクセラレーションプログラム").where.not(classification: "X-Hub").where.not(title: "内閣府アクセラレーションプログラム Enterpriseコース")
    else
      @btob = nil
    end

    if @form.series == "シリーズC〜"
      @seriesc = Solution.where(title: "グローバル・アクセラレーション・ハブ").or(Solution.where.not(classification: "X-Hub").where(description: "長期アクセラレーションプログラム"))
    else
      @seriesc = nil
    end

    if @form.objective == "販路開拓"
      @selling = Solution.where(title: "グローバル・アクセラレーション・ハブ")
    else
      @selling = nil
    end

    if @form.industry == "環境・エネルギー"
      @cleantech = Solution.where(description: "長期アクセラレーションプログラム").where.not(classification: "X-Hub").where.not(title: "内閣府アクセラレーションプログラム CleanTechコース")
    else
      @cleantech = nil
    end

    if @form.industry == "バイオ・医療"
      @bio = Solution.where(description: "長期アクセラレーションプログラム").where.not(classification: "X-Hub").where.not(title: "内閣府アクセラレーションプログラム Bio/Healthcareコース")
    else
      @bio = nil
    end

    if @form.industry == "大学発ディープテック"
      @university = Solution.where(description: "長期アクセラレーションプログラム").where.not(classification: "X-Hub").where.not(title: "内閣府アクセラレーションプログラム Universityコース")
    else
      @university = nil
    end

    if @form.industry == "その他"
      @other = Solution.where(title: "内閣府アクセラレーションプログラム Universityコース").or(Solution.where(title: "内閣府アクセラレーションプログラム Bio/Healthcareコース")).or(Solution.where(title: "内閣府アクセラレーションプログラム CleanTechコース"))
    else
      @other = nil
    end

    if !@form.region.include?("アジア")
      @asia = Solution.where(title: "Ignite").or(Solution.where(title: "X-Hub 深センコース")).or(Solution.where(title: "X-Hub シリコンバレーコース"))
    else
      @asia = nil
    end

    if !@form.region.include?("北米")
      @usa = Solution.where(title: "CES").or(Solution.where(title: "Disrupt")).or(Solution.where(title: "Collision")).
      or(Solution.where(title: "X-Hub ニューヨークコース")).or(Solution.where(title: "X-Hub シリコンバレーコース"))
    else
      @usa = nil
    end

    if !@form.region.include?("アフリカ")
      @africa = Solution.where(title: "Gitex Future Stars")
    else
      @africa = nil
    end

    if !@form.region.include?("欧州")
      @europe = Solution.where(title: "X-Hub ドイツコース").or(Solution.where(title: "VIVA Tech")).or(Solution.where(title: "欧州カンファレンスコース")).or(Solution.where(title: "4 Years From Now"))
    else
      @europe = nil
    end

    if !@form.objective.include?("協業連携") && !@form.objective.include?("販路開拓") && !@form.objective.include?("資金調達")&& !@form.objective.include?("市場調査")
      @objective_for_acceleration = Solution.where(description: "長期アクセラレーションプログラム")
    else
      @objective_for_acceleration = nil
    end

    if !@form.region.include?("人材獲得")
      @recruitment = Solution.where(title: "Japan Day")
    else
      @rectruitment = nil
    end


    @solutions = Solution.where.not(id: @software).where.not(id: @seriesc).where.not(id: @cleantech).where.not(id: @bio).where.not(id: @other).where.not(id: @university).
    where.not(id: @asia).where.not(id: @usa).where.not(id: @africa).where.not(id: @europe).
    where.not(id: @selling).where.not(id: @objective_for_acceleration).where.not(title: "始動").where.not(title: "貿易実務相談").where.not(id: @recruitment).
    where.not(id: @seriesab).where.not(id: @btob)

    if @form.series == "スタートアップではない"
      @solutions = Solution.where(title: "始動").or(Solution.where(title: "貿易投資相談"))
    end
  end

  private
    def form_params #ストロングパラメータ
      params.require(:form).permit(:industry, :series, :product_type, :company_type, {:region => []},{:objective => []}, :field, :objective) #パラメーターのキー
    end

end
